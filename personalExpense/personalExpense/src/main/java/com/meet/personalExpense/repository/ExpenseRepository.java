package com.meet.personalExpense.repository;

import com.meet.personalExpense.model.Expense;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface ExpenseRepository extends JpaRepository<Expense, Long> {

//    @Query("SELECT e FROM Expense e where " +
//            "(:category IS NULL OR e.category = :category) AND"
//            + "(:startDate IS NULL OR TO_DATE(e.date, '%Y-%m-%d') >= :startDate) AND " +
//            "(:endDate IS NULL OR TO_DATE(e.date, '%Y-%m-%d') <= :endDate) " +
//            "ORDER BY " +
//            "CASE WHEN :sortBy = 'amount' THEN e.amount END ASC, " +
//            "CASE WHEN :sortBy = 'date' THEN e.date END ASC")
//    List<Expense> findExpenses(@Param("category") String category, @Param("startDate")LocalDate startDate, @Param("endDate") LocalDate endDate, @Param("sortBy") String sortBy);


}
