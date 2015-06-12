App.addChild('MoipForm', _.extend({
  el: 'form.moip',

  events: {
    'blur input:not(#payment_card_cpf):not(#user_document_payment_slip)' : 'checkInput'
  },


  getMoipToken: function(onSuccess){
    var that = this;
    if($('#MoipWidget').length > 0) {
      if(_.isFunction(onSuccess)){
        onSuccess();
      }
    } else {
      $.post('/payment/moip/' + this.contributionId + '/get_moip_token').success(function(response, textStatus){
        that.paymentChoice.$('input').attr('disabled', 'disabled');
        if(response.get_token_response.status == 'fail'){
          that.checkoutFailure({Code: 0, Mensagem: response.get_token_response.message});
        }
        else{
          that.createMoipWidget(response);
          if(_.isFunction(onSuccess)){
            onSuccess(response);
          }
        }
      });
    }
  },

  createMoipWidget: function(data) {
    widget_tag = $("<div/>").attr({
      id: data.widget_tag.tag_id,
      'data-token': data.widget_tag.token,
      'callback-method-success': data.widget_tag.callback_success,
      'callback-method-error': data.widget_tag.callback_error,
    });

    $("#catarse_moip_form").prepend(widget_tag);
  },

  checkoutFailure: function(data) {
    this.loader.hide();
    var response_data = (data.length > 0 ? data[0] : data);
    if(response_data.Codigo == 914){
      response_data.Mensagem += '. Tente <a href="javascript:window.location.reload();">recarregar a página</a> e repetir a operação de pagamento.';
    }
    this.message.find('.message-text').html(response_data.Mensagem);
    this.message.slideDown('slow');
  },

  checkoutSuccessful: function(data) {
    var that = this;
    $.post('/payment/moip/' + this.contributionId + '/moip_response', {response: data}).success(function(){
      that.loader.hide();
      // Bail out when get an error from MoIP
      if(data.Status == 'Cancelado'){
        return that.checkoutFailure({Codigo: 0, Mensagem: data.Classificacao.Descricao + '. Verifique os dados de pagamento e tente novamente.'})
      }

      // Go on otherwise
      if(data.url && $('#payment_type_cards_section').css('display') != 'block') {
        var link = $('<a class="alt-link" target="__blank">Clique aqui para ver o boleto e completar o pagamento.</a>')
        link.attr('href', data.url);
        $('.link_content').empty().html(link);
        $('#payment-slip-link').slideDown('slow');
      }
      else {
        var thank_you = $('#project_review').data('thank-you-path');
        if(thank_you){
          location.href = thank_you;
        }
        else {
          location.href = '/';
        }
      }
    });
  },

  activate: function(){
    this.message = this.$('.payment-error-message');
    this.contributionId = $('input#contribution_id').val();
    this.projectId = $('input#contribution_project_id').val();

    this.loader = this.$('.loader img');

    window.checkoutSuccessful = _.bind(this.checkoutSuccessful, this);
    window.checkoutFailure = _.bind(this.checkoutFailure, this);
    this.setupForm();
  }
}, Skull.Form));

App.views.MoipForm.UserDocument = {
  onContentClick: function(e){
    window.setTimeout(function(){
      app.moipForm.checkoutSuccessful({'StatusPagamento': 'Success'});
    }, 2000);
  },

  onUserDocumentKeyup: function(e){
    var $documentField = $(e.currentTarget);

    var documentNumber = $documentField.val();
    $documentField.prop('maxlength', 18);
    var resultCpf = this.validateCpf(documentNumber);
    var resultCnpj = this.validateCnpj(documentNumber.replace(/[\/.\-\_ ]/g, ''));
    var numberLength = documentNumber.replace(/[.\-\_ ]/g, '').length
    if(numberLength > 10) {
      if($documentField.attr('id') != 'payment_card_cpf'){
        if(numberLength == 11) {$documentField.mask('999.999.999-99?999'); }//CPF
        else if(numberLength == 14 ){$documentField.mask('99.999.999/9999-99');}//CNPJ
        if(numberLength != 14 || numberLength != 11){ $documentField.unmask()}
      }

      if(resultCpf || resultCnpj) {
        $('[data-error-for=' + $documentField.prop('id') + ']').hide();
        $documentField.addClass('ok').removeClass('error');

        $.ajax({
          url: '/projects/' + this.moipForm.projectId + '/contributions/' + this.moipForm.contributionId,
          type: 'PUT',
          data: { contribution: { payer_document: documentNumber } }
        });

      } else {
        $documentField.trigger('invalid');
      }
    }
    else{
      $documentField.trigger('invalid')
    }

  },

  validateCpf: function(cpfString){
    var product = 0, i, digit;
    cpfString = cpfString.replace(/[.\-\_ ]/g, '');
    var aux = Math.floor(parseFloat(cpfString) / 100);
    var cpf = aux * 100;
    var quotient;

    for(i=0; i<=8; i++){
      product += (aux % 10) * (i+2);
      aux = Math.floor(aux / 10);
    }
    digit = product % 11 < 2 ? 0 : 11 - (product % 11);
    cpf += (digit * 10);
    product = 0;
    aux = Math.floor(cpf / 10);
    for(i=0; i<=9; i++){
      product += (aux % 10) * (i+2);
      aux = Math.floor(aux / 10);
    }
    digit = product % 11 < 2 ? 0 : 11 - (product % 11);
    cpf += digit;
    return parseFloat(cpfString) === cpf;
  },

  validateCnpj: function(cnpj) {
    var numeros, digitos, soma, i, resultado, pos, tamanho, digitos_iguais;
    digitos_iguais = 1;
    if (cnpj.length < 14 && cnpj.length < 15)
      return false;
    for (i = 0; i < cnpj.length - 1; i++)
    if (cnpj.charAt(i) != cnpj.charAt(i + 1))
      {
        digitos_iguais = 0;
        break;
      }
      if (!digitos_iguais)
        {
          tamanho = cnpj.length - 2
          numeros = cnpj.substring(0,tamanho);
          digitos = cnpj.substring(tamanho);
          soma = 0;
          pos = tamanho - 7;
          for (i = tamanho; i >= 1; i--)
          {
            soma += numeros.charAt(tamanho - i) * pos--;
            if (pos < 2)
              pos = 9;
          }
          resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
          if (resultado != digitos.charAt(0))
            return false;
          tamanho = tamanho + 1;
          numeros = cnpj.substring(0,tamanho);
          soma = 0;
          pos = tamanho - 7;
          for (i = tamanho; i >= 1; i--)
          {
            soma += numeros.charAt(tamanho - i) * pos--;
            if (pos < 2)
              pos = 9;
          }
          resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
          if (resultado != digitos.charAt(1))
            return false;
          return true;
        }
        else
          return false;
  }
};


App.views.MoipForm.addChild('PaymentAccount', _.extend({
  el: '#payment_type_account_section',

  events: {
    'change select#account' : 'onChangeAccount',
    'click input#build_account_link' : 'onBuildAccountClick',
    'keyup #user_document_account' : 'onUserDocumentKeyup',
    'click .link_content a' : 'onContentClick',
  },

  activate: function(){
    this.moipForm = this.parent;
    this.$('input#user_document_account').mask("999.999.999-99");
  },

  onChangeAccount: function(e){
    var value = $(e.currentTarget).val();
    this.$('input#build_account_link').attr('disabled', !(value != "" && value != undefined));
  },

  onBuildAccountClick: function(e) {
    var that = this;
    e.preventDefault();
    $(e.currentTarget).hide();
    that.moipForm.loader.show();

    // Get token and send payment
    that.moipForm.getMoipToken(function(){
      var settings = {
        "Instituicao": $('select#account').val(),
        "Forma": "DebitoBancario"
      }
      MoipWidget(settings);
    });
  }
}, App.views.MoipForm.UserDocument));

App.views.MoipForm.addChild('PaymentCard', _.extend({
  el: '#payment_type_cards_section',
  
  events: {
    'keyup #payment_card_number' : 'onKeyupPaymentCardNumber',
    'click #credit_card_submit' : 'onSubmit',
    'blur #payment_card_cpf' : 'onUserDocumentKeyup'
  },

  activate: function(options){
    // Set credit card fields masks
    this.moipForm = this.parent;
    this.$('#payment_card_number').payment('formatCardNumber');
    window.app.maskAllElements();
  },

  onKeyupPaymentCardNumber: function(e){
    this.$('#payment_card_flag').html(this.getCardFlag($(e.currentTarget).val()))
  },

  onSubmit: function(e) {
    var that = this;
    e.preventDefault();

    if(!that.moipForm.validate()){
      return false;
    }

    that.moipForm.loader.show();

    // Get token and send payment
    that.moipForm.getMoipToken(function(){
      var settings = {
        "Forma": "CartaoCredito",
        "Instituicao": that.$('input#payment_card_flag').val(),
        "Parcelas": "1",
        "Recebimento": "AVista",
        "CartaoCredito": {
          "Numero": that.$('input#payment_card_number').val(),
          "Expiracao": that.$('input#payment_card_date').val(),
          "CodigoSeguranca": that.$('input#payment_card_source').val(),
          "Portador": {
            "Nome": that.$('input#payment_card_name').val(),
            "DataNascimento": that.$('input#payment_card_birth').val(),
            "Telefone": that.$('input#payment_card_phone').val(),
            "Identidade": that.$('input#payment_card_cpf').val()
          }
        }
      };
      MoipWidget(settings);
    });
  },

  getCardFlag: function(number) {
    return $.payment.cardType(number).toUpperCase();
  }
}, App.views.MoipForm.UserDocument));
App.views.MoipForm.addChild('PaymentChoice', {
  el: '.list_payment',

  events: {
    'change input[type="radio"]' : 'onListPaymentChange'
  },

  onListPaymentChange: function(e){
    $('.payment_section').fadeOut('fast', function(){
      var currentElementId = $(e.currentTarget).attr('id');
      $('#'+currentElementId+'_section').fadeIn('fast');
    });
  },

  activate: function(){
    this.$('input#payment_type_cards').click();
  }
});

App.views.MoipForm.addChild('PaymentSlip', _.extend({
  el: '#payment_type_boleto_section',

  events: {
    'click input#build_boleto' : 'onBuildBoletoClick',
    'click .link_content a' : 'onContentClick',
    'blur #user_document_payment_slip' : 'onUserDocumentKeyup'
  },

  activate: function(options){
    this.moipForm = this.parent;
  },

  onBuildBoletoClick: function(e){
    var that = this;
    e.preventDefault();

    if(!that.moipForm.validate()){
      return false;
    }

    $(e.currentTarget).hide();
    this.$('#payment-slip-instructions').slideUp('slow');
    that.moipForm.loader.show();

    // Get token and send payment
    that.moipForm.getMoipToken(function(){
      var settings = {
        "Forma":"BoletoBancario"
      }
      MoipWidget(settings);
    });
  }
}, App.views.MoipForm.UserDocument));




$(function(){
  app.createViewGetters();
});