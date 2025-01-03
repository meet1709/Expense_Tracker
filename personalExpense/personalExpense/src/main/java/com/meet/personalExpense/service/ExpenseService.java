package com.meet.personalExpense.service;

import com.meet.personalExpense.model.Expense;
import com.meet.personalExpense.repository.ExpenseRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

@Service
public class ExpenseService {

    private final ExpenseRepository expenseRepository;

    public ExpenseService(ExpenseRepository expenseRepository) {
        this.expenseRepository = expenseRepository;
    }

    public List<Expense> getAllExpenses() {
        return expenseRepository.findAll();
    }

    public Expense saveExspense(Expense expense) {
        return expenseRepository.save(expense);
    }

    public boolean updateExpense(Long id, Expense expense) {
        if(expenseRepository.existsById(id)){
            System.out.println(expense.toString());
            expense.setId(id);
            Expense updatedExpense = expenseRepository.save(expense);
            return true;
        }
        else {
            return false;
        }

    }

    public boolean deleteExpense(Long id) {
        if (expenseRepository.existsById(id)) {
            expenseRepository.deleteById(id);
            return true;

        }

        return false;
    }

//
//    public List<Expense> getFilteredExpensesWithQuery(String category, LocalDate startDate, LocalDate endDate, String sortBy) {
//        return expenseRepository.findExpenses(category, startDate, endDate, sortBy);
//    }


    public List<Expense> getFilteredExpenses(String category, LocalDate startDate, LocalDate endDate, String sortBy){

        System.out.println("category:" + category);
        System.out.println("startDate:" + startDate);
        System.out.println("endDate:" + endDate);
        System.out.println("sortBy:" + sortBy);

        List<Expense> allExpenses = expenseRepository.findAll();

        return allExpenses.stream().filter(e -> (category == null || category.isEmpty() || e.getCategory().equals(category)) && (startDate == null || startDate.lengthOfYear() == 0 || LocalDate.parse(e.getDate()).isEqual(startDate) || LocalDate.parse(e.getDate()).isAfter(startDate))  &&

                        (endDate == null  || endDate.lengthOfYear() == 0 || LocalDate.parse(e.getDate()).isBefore(endDate) || LocalDate.parse(e.getDate()).isEqual(endDate))

                ).sorted((e1,e2) -> {

                    if("amount".equals(sortBy)){
                        return Double.compare(e1.getAmount() , e2.getAmount());
                    }else if("date".equals(sortBy)){
                        return LocalDate.parse(e1.getDate()).compareTo(LocalDate.parse(e2.getDate()));

                    }

                    return 0;


        }).collect(Collectors.toList());
    }
}
