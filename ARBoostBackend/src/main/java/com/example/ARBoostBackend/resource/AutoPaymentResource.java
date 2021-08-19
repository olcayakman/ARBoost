package com.example.ARBoostBackend.resource;

import com.example.ARBoostBackend.model.AutoPayment;
import com.example.ARBoostBackend.repository.AutoPaymentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/auto_payment")
public class AutoPaymentResource {


    class PaymentDate{
        String month;
        int day;

        public PaymentDate(String month, int day){
            this.day = day;
            this.month = month;
        }

        public String getMonth() {
            return month;
        }

        public int getDay() {
            return day;
        }
    }

    @Autowired
    AutoPaymentRepository autoPaymentRepository;

    @GetMapping("/all")
    public List<AutoPayment> getAll(){
        return autoPaymentRepository.findAll();
    }

    @GetMapping("/card_no={cardNo}")
    public List<AutoPayment> getPaymentByCardNo(@PathVariable("cardNo") String cardNo){
        return autoPaymentRepository.getAutoPaymentByCardNo(cardNo);
    }

    @GetMapping("/near/card_no={cardNo}")
    public AutoPayment getNearestPaymentByCardNo(@PathVariable("cardNo") String cardNo){
        List<AutoPayment> payments = autoPaymentRepository.getAutoPaymentByCardNo(cardNo);

        Calendar c = Calendar.getInstance();

        Date current = new Date();
        c.setTime(current);

        AutoPayment nearest = payments.get(0);

        long interval = Long.MAX_VALUE;

        for (AutoPayment p : payments){
            c.setTime(current);
            int day = p.getPaymentDay();
            long diffInMillies = c.getTimeInMillis();
            if (day < c.get(Calendar.DAY_OF_MONTH)){
                c.add(Calendar.MONTH, 1);
                c.set(Calendar.DAY_OF_MONTH, day);
                diffInMillies -= c.getTimeInMillis();
                diffInMillies = -diffInMillies;
            }
            else{
                c.set(Calendar.DAY_OF_MONTH, day);
                diffInMillies -= c.getTimeInMillis();

            }
            if(diffInMillies < interval){
                interval = diffInMillies;
                nearest = p;
            }
        }

        String month = new SimpleDateFormat("MMMMMMMM").format(c.getTime());
        int day = nearest.getPaymentDay();
        return nearest;
    }



}
