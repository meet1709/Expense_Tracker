package com.meet.personalExpense.repository;

import com.meet.personalExpense.model.Budget;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BudgetRepository extends JpaRepository<Budget,Integer> {
}
