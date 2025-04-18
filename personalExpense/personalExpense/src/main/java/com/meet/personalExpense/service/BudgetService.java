package com.meet.personalExpense.service;

import com.meet.personalExpense.model.Budget;
import com.meet.personalExpense.repository.BudgetRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class BudgetService {

    private  BudgetRepository budgetRepository;


    public BudgetService(BudgetRepository budgetRepository) {
        this.budgetRepository = budgetRepository;
    }

    public List<Budget> getAllMonthsBudget(){
        return budgetRepository.findAll();
    }

    public Budget getMonthBudget(int month){


            Optional<Budget> budget = budgetRepository.findById(month);

            return budget.orElse(new Budget(month, 0));




    }

    public boolean updateMonthBudget(int month, double budget){
        if(budgetRepository.existsById(month)){
            System.out.println("Updating Budget for " + month);
            budgetRepository.save(new Budget(month, budget));
            return true;
        }

        return false;

    }

    public Budget saveBudget(Budget budget) {
        return budgetRepository.save(budget);
    }
}
