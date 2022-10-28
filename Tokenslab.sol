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
                overflowHandler(slabValues[currentSlab] - slabLimits[currentSlab]);
            }
        }

        function overflowHandler(uint64 overFlow) private 
        {
        //    overFlow = slabValues[currentSlab] - slabLimits[currentSlab];
            slabValues[currentSlab] = slabLimits[currentSlab];
            currentSlab = currentSlab - 1;

            require(currentSlab >= 0, "All slabs are full, more tokens cannot be added");

            slabValues[currentSlab] += overFlow;

            if(slabValues[currentSlab] > slabLimits[currentSlab])
            {
                overflowHandler(slabValues[currentSlab] - slabLimits[currentSlab]);
            }
            
        } 

        function viewSlabDetails() public view returns(uint8)
        {
            return(currentSlab);
        }

    }