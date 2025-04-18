package com.meet.personalExpense.controller;

import com.meet.personalExpense.model.Budget;
import com.meet.personalExpense.service.BudgetService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/budget")
@CrossOrigin(origins = "*")
public class BudgetController {


    private BudgetService budgetService;


    public BudgetController(BudgetService budgetService) {
        this.budgetService = budgetService;
    }


    @GetMapping
    public List<Budget> getAllMonthBudgets(){
        return budgetService.getAllMonthsBudget();

    }


    @PostMapping("/{month}")
    public Budget addBudget(@PathVariable String month, @RequestBody Budget budget){
        return budgetService.saveBudget(budget);
    }

    @GetMapping("/{month}")
    public ResponseEntity<Budget> getMonthBudget(@PathVariable int month){
        Budget budget = budgetService.getMonthBudget(month);

        if(budget.getBudget() != 0.0 ){
            return ResponseEntity.ok(budget);
        }
        else{
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }




    }


    @PutMapping("/{month}")
    public ResponseEntity<Budget> updateMonthBudget(@PathVariable String month, @RequestBody Budget budget){
        Boolean isupdated = budgetService.updateMonthBudget(budget.getMonth(), budget.getBudget());

        if(isupdated && budget.getMonth() == Integer.parseInt(month)){
            return ResponseEntity.ok(budget);
        }
        else{
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }




    }
}
