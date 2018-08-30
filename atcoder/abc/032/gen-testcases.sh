#!/bin/bash

MID_CASE=in-gen-mid.txt
SIGMA_V_CASE=in-gen-sigma-v.txt
SIGMA_W_CASE=in-gen-sigma-w.txt

# meet in the mid
# 1 <= N <= 30
# 1 <= W <= 10^9
N1=$((RANDOM%30))
W1=$((RANDOM%1000000000))

# sigma v
# 1 <= N <= 300
# 1 <= W <= 10^9
N2=$((RANDOM%30+170))
W2=$((RANDOM%1000000000))

# sigma w
# 1 <= N <= 300
# 1 <= W <= 10^9
N3=$((RANDOM%30+170))
W3=$((RANDOM%1000000000))

### show ###
#echo "meet in the mid"
echo "${N1} ${W1}" > ${MID_CASE}
for i in `seq 1 ${N1}`; do
    VI=$((RANDOM%1000000000))
    WI=$((RANDOM%1000000000))
    echo "${VI} ${WI}" >> ${MID_CASE}
done
echo ""

#echo "sigma v"
echo "${N2} ${W2}" > ${SIGMA_V_CASE}
for i in `seq 1 ${N2}`; do
    VI=$((RANDOM%1000))
    WI=$((RANDOM%1000000000))
    echo "${VI} ${WI}" >> ${SIGMA_V_CASE}
done
echo ""

#echo "sigma w"
echo "${N3} ${W3}" > ${SIGMA_W_CASE}
for i in `seq 1 ${N3}`; do
    VI=$((RANDOM%1000000000))
    WI=$((RANDOM%1000))
    echo "${VI} ${WI}" >> ${SIGMA_W_CASE}
done

## mid
dmd D.d -ofDD
echo "mid with dlang"
time cat ${MID_CASE} | ./DD
echo ""
# v
echo "01 knapsack v"
time cat ${SIGMA_V_CASE} | ./DD
echo ""
# w
echo "01 knapsack w"
time cat ${SIGMA_W_CASE} | ./DD
echo ""
