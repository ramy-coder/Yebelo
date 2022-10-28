    //SPDX-License-Identifier: MIT
    pragma solidity ^0.8.0;

    contract Tokenslab {
        uint8 currentSlab;
        uint32[5] slabLimits;
        uint64[5] slabValues;

        constructor()
        {
            //initialiing the values 
            slabLimits = [100,200,300,400,500];
            currentSlab = 4; //slabs are 4,3,3,1 and 0
            slabValues = [0,0,0,0,0];
        }

        function tokenDeposit(uint64 noofTokens) public
        {
            //When a ERC20 token is deposited, it occupies the highest level and if  the capacity reaches the maximum, it goes to the next lower level 
            slabValues[currentSlab] += noofTokens;
            if(slabValues[currentSlab] > slabLimits[currentSlab])
            {
                overflowHandler(slabValues[currentSlab] - slabLimits[currentSlab]);
            }
        }

        function overflowHandler(uint64 overFlow) private 
        {
            // an internal function logic to handle overflows and sorting the tokens into the correct slab
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
            // To view the current slab of the deposited tokens
            return(currentSlab);
        }

    }