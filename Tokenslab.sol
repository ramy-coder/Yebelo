    //SPDX-License-Identifier: MIT
    pragma solidity ^0.8.0;

    contract Tokenslab {
        uint8 currentSlab;
        uint32[5] slabLimits;
        uint64[5] slabValues;

        constructor()
        {
            slabLimits = [100,200,300,400,500];
            currentSlab = 4;
            slabValues = [0,0,0,0,0];
        }

        function tokenDeposit(uint64 noofTokens) public
        {
            slabValues[currentSlab] += noofTokens;
            if(slabValues[currentSlab] > slabLimits[currentSlab])
            {
                overflowHandler();
            }
        }

        function overflowHandler() private 
        {
            uint64 overFlow;
            overFlow = slabValues[currentSlab] - slabLimits[currentSlab];
            slabValues[currentSlab] = slabLimits[currentSlab];
            currentSlab = currentSlab - 1;

            
        } 

    }