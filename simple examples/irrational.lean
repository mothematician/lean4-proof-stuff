import data.nat.prime
open nat

theorem sqrt_two_irrational {a b : ℕ} (co : gcd a b = 1) :
  a^2 ≠ 2 * b^2 :=
assume h : a^2 = 2 * b^2,
have 2 ∣ a^2,
  by simp [h],
have 2 ∣ a,
  from prime.dvd_of_dvd_pow prime_two this,
exists.elim this $
assume (c : nat) (aeq : a = 2 * c),
have 2 * (2 * c^2) = 2 * b^2,
  by simp [eq.symm h, aeq];
    simp [pow_succ', mul_comm, mul_assoc, mul_left_comm],
have 2 * c^2 = b^2,
  from mul_left_cancel' dec_trivial this,
have 2 ∣ b^2,
  by simp [eq.symm this],
have 2 ∣ b,
  from prime.dvd_of_dvd_pow prime_two this,
have 2 ∣ gcd a b,
  from dvd_gcd ‹2 ∣ a› ‹2 ∣ b›,
have 2 ∣ (1 : ℕ),
  by simp * at *,
show false, from absurd ‹2 ∣ 1› dec_trivial