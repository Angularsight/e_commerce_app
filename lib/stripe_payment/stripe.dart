



//This class checks if the payment was successful or not

class StripeTransactionResponse{
  String message;
  bool success;
  StripeTransactionResponse({required this.message,required this.success});

}

//This class has payment methods that we will use it later
class StripeService{
  static String apiBase = 'https://api.stripe.com/v1';

}