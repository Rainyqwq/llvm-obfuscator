; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -instcombine < %s | FileCheck %s

declare double @llvm.pow.f64(double, double)

define double @pow_ab_a(double %a, double %b)  {
; CHECK-LABEL: @pow_ab_a(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.pow.f64(double [[A:%.*]], double [[B:%.*]])
; CHECK-NEXT:    [[MUL:%.*]] = fmul double [[TMP1]], [[A]]
; CHECK-NEXT:    ret double [[MUL]]
;
  %1 = call double @llvm.pow.f64(double %a, double %b)
  %mul = fmul double %1, %a
  ret double %mul
}

define double @pow_ab_a_reassoc(double %a, double %b)  {
; CHECK-LABEL: @pow_ab_a_reassoc(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.pow.f64(double [[A:%.*]], double [[B:%.*]])
; CHECK-NEXT:    [[MUL:%.*]] = fmul reassoc double [[TMP1]], [[A]]
; CHECK-NEXT:    ret double [[MUL]]
;
  %1 = call double @llvm.pow.f64(double %a, double %b)
  %mul = fmul reassoc double %1, %a
  ret double %mul
}

define double @pow_ab_a_reassoc_commute(double %a, double %b)  {
; CHECK-LABEL: @pow_ab_a_reassoc_commute(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.pow.f64(double [[A:%.*]], double [[B:%.*]])
; CHECK-NEXT:    [[MUL:%.*]] = fdiv reassoc double [[TMP1]], [[A]]
; CHECK-NEXT:    ret double [[MUL]]
;
  %1 = fdiv double 1.0, %a
  %2 = call double @llvm.pow.f64(double %a, double %b)
  %mul = fmul reassoc double %1, %2
  ret double %mul
}

define double @pow_ab_pow_cb(double %a, double %b, double %c) {
; CHECK-LABEL: @pow_ab_pow_cb(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.pow.f64(double [[A:%.*]], double [[B:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.pow.f64(double [[C:%.*]], double [[B]])
; CHECK-NEXT:    [[MUL:%.*]] = fmul double [[TMP2]], [[TMP1]]
; CHECK-NEXT:    ret double [[MUL]]
;
  %1 = call double @llvm.pow.f64(double %a, double %b)
  %2 = call double @llvm.pow.f64(double %c, double %b)
  %mul = fmul double %2, %1
  ret double %mul
}

define double @pow_ab_pow_cb_reassoc(double %a, double %b, double %c) {
; CHECK-LABEL: @pow_ab_pow_cb_reassoc(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.pow.f64(double [[A:%.*]], double [[B:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.pow.f64(double [[C:%.*]], double [[B]])
; CHECK-NEXT:    [[MUL:%.*]] = fmul reassoc double [[TMP2]], [[TMP1]]
; CHECK-NEXT:    ret double [[MUL]]
;
  %1 = call double @llvm.pow.f64(double %a, double %b)
  %2 = call double @llvm.pow.f64(double %c, double %b)
  %mul = fmul reassoc double %2, %1
  ret double %mul
}

define double @pow_ab_pow_ac(double %a, double %b, double %c) {
; CHECK-LABEL: @pow_ab_pow_ac(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.pow.f64(double [[A:%.*]], double [[B:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.pow.f64(double [[A]], double [[C:%.*]])
; CHECK-NEXT:    [[MUL:%.*]] = fmul double [[TMP2]], [[TMP1]]
; CHECK-NEXT:    ret double [[MUL]]
;
  %1 = call double @llvm.pow.f64(double %a, double %b)
  %2 = call double @llvm.pow.f64(double %a, double %c)
  %mul = fmul double %2, %1
  ret double %mul
}

define double @pow_ab_x_pow_ac_reassoc(double %a, double %b, double %c) {
; CHECK-LABEL: @pow_ab_x_pow_ac_reassoc(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.pow.f64(double [[A:%.*]], double [[B:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.pow.f64(double [[A]], double [[C:%.*]])
; CHECK-NEXT:    [[MUL:%.*]] = fmul reassoc double [[TMP2]], [[TMP1]]
; CHECK-NEXT:    ret double [[MUL]]
;
  %1 = call double @llvm.pow.f64(double %a, double %b)
  %2 = call double @llvm.pow.f64(double %a, double %c)
  %mul = fmul reassoc double %2, %1
  ret double %mul
}
