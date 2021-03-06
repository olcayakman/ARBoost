package com.example.card_io_setup;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import androidx.appcompat.app.AppCompatActivity;

import com.example.card_io_setup.Entity.CreditCardEntity;
import com.example.card_io_setup.Entity.User;
import com.example.card_io_setup.backend.ApiClient;

import java.util.List;

import io.card.payment.CardIOActivity;
import io.card.payment.CreditCard;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class MainActivity extends AppCompatActivity {
    Button girisButonu;
    int MY_SCAN_REQUEST_CODE = 111;

    private AlertDialog.Builder dialogBuilder;
    private AlertDialog dialog;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.hosgeldin_ekrani);


        girisButonu = findViewById(R.id.girisButonu);
        getCreditCardInfo();

        girisButonu.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                onButtonListener();
            }
        });

    }

    private void getCreditCardInfo(){
        Call<List<CreditCardEntity>> creditCards = ApiClient.getCreditCardService().getAllCards();

        creditCards.enqueue(new Callback<List<CreditCardEntity>>() {
            @Override
            public void onResponse(Call<List<CreditCardEntity>> call, Response<List<CreditCardEntity>> response) {
                if(response.isSuccessful()){
                    List<CreditCardEntity> creditCards = response.body();

                    for (CreditCardEntity c: creditCards){
                        System.out.println(c.getDebt());
                    }

                }
            }

            @Override
            public void onFailure(Call<List<CreditCardEntity>> call, Throwable t) {
                t.printStackTrace();
            }
        });
    }


    private void onButtonListener(){

        EditText editTextTckn = findViewById(R.id.editTextTextPersonName);
        String tckn = editTextTckn.getText().toString();

        Call<User> user = ApiClient.getUserService().getUserByTckn(tckn);



        user.enqueue(new Callback<User>() {
            @Override
            public void onResponse(Call<User> call, Response<User> response) {
                if(response.isSuccessful()){
                    User u = response.body();

                    EditText editTextPassword = findViewById(R.id.editTextNumberPassword);
                    String password = editTextPassword.getText().toString();
                    if (u.getPassword().equals(password)){
                        getArView();
                    }
                    else{
                        createNewDialog();
                        System.out.println("Yanl???? ??ifre");
                    }
                }
                else {
                    // Buraya da pop up eklenecek
                    Toast.makeText(getApplicationContext(),"TC Kimlik Numaran??z hatal??d??r.",Toast.LENGTH_SHORT).show();
                    System.out.println("TC YANLI??");
                }
            }

            @Override
            public void onFailure(Call<User> call, Throwable t) {
                t.printStackTrace();
            }
        });
    }

    protected void getArView(){
        Intent scanIntent = new Intent(this, CardIOActivity.class);

        // customize these values to suit your needs.
        scanIntent.putExtra(CardIOActivity.EXTRA_REQUIRE_EXPIRY, true); // default: false
        scanIntent.putExtra(CardIOActivity.EXTRA_REQUIRE_CVV, false); // default: false
        scanIntent.putExtra(CardIOActivity.EXTRA_REQUIRE_POSTAL_CODE, false); // default: false
        scanIntent.putExtra(CardIOActivity.EXTRA_SUPPRESS_CONFIRMATION, true);
        // MY_SCAN_REQUEST_CODE is arbitrary and is only used within this activity.
        startActivityForResult(scanIntent, MY_SCAN_REQUEST_CODE);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == MY_SCAN_REQUEST_CODE) {
            String resultDisplayStr;
            if (data != null && data.hasExtra(CardIOActivity.EXTRA_SCAN_RESULT)) {
                CreditCard scanResult = data.getParcelableExtra(CardIOActivity.EXTRA_SCAN_RESULT);

                // Never log a raw card number. Avoid displaying it, but if necessary use getFormattedCardNumber()
                resultDisplayStr = "Card Number: " + scanResult.getRedactedCardNumber() + "\n";

                // Do something with the raw number, e.g.:
                // myService.setCardNumber( scanResult.cardNumber );

                if (scanResult.isExpiryValid()) {
                    resultDisplayStr += "Expiration Date: " + scanResult.expiryMonth + "/" + scanResult.expiryYear + "\n";
                }

                if (scanResult.cvv != null) {
                    // Never log or display a CVV
                    resultDisplayStr += "CVV has " + scanResult.cvv.length() + " digits.\n";
                }

                if (scanResult.postalCode != null) {
                    resultDisplayStr += "Postal Code: " + scanResult.postalCode + "\n";
                }
            }
            else {
                resultDisplayStr = "Scan was canceled.";
            }
            // do something with resultDisplayStr, maybe display it in a textView
            // textView.setText(resultDisplayStr);
            System.out.println(resultDisplayStr);
        }
        // else handle other activity results
    }

    public void createNewDialog(){
        dialogBuilder = new AlertDialog.Builder (this);
        final View contactPopupView = getLayoutInflater().inflate(R.layout.popupSifre, null);

        //popup xml dosyasina gore buttonlar baglanabilir burada
        dialogBuilder.setView(contactPopupView);
        dialog = dialogBuilder.create();
        dialog.show();
    }


}