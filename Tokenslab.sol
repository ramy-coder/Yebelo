    //SPDX-License-Identifier: MIT
    pragma solidity ^0.8.0;

    contract Tokenslab {
        uint8 currentSlab;
        uint32[5] slabLimits;
        uint32[5] slabValues;

        constructor()
        {
            //initialiing the values 
            slabLimits = [100,200,300,400,500];
            currentSlab = 4; //slabs are 4,3,3,1 and 0
            slabValues = [0,0,0,0,0];
        }

        function tokenDeposit(uint32 noofTokens) public
        {
            //When a ERC20 token is deposited, it occupies the highest level and if  the capacity reaches the maximum, it goes to the next lower level 
            slabValues[currentSlab] += noofTokens;
            if(slabValues[currentSlab] > slabLimits[currentSlab])
            {
                uint32 excess;
                excess = slabValues[currentSlab] - slabLimits[currentSlab];
                slabValues[currentSlab] -= excess;
                overflowHandler(excess);
            }
        }

        function overflowHandler(uint32 overFlow) private 
        {
            // an internal function logic to handle overflows and sorting the tokens into the correct slab
            slabValues[currentSlab] = slabLimits[currentSlab];
            currentSlab = currentSlab - 1;

            require(currentSlab >= 0, "All slabs are full, more tokens cannot be added");

            slabValues[currentSlab] += overFlow;

            if(slabValues[currentSlab] > slabLimits[currentSlab])
            {
                uint32 excess;
                excess = slabValues[currentSlab] - slabLimits[currentSlab];
                slabValues[currentSlab] -= excess;
                overflowHandler(excess);
            }
            
        } 

        function viewSlabDetails() public view returns(uint8)
        {
            // To view the current slab of the deposited tokens
            return(currentSlab);
        }

        function viewSlabvalues(uint8 slabInd) public view returns(uint32)
        {
            // To view the current slab values of the given Slab Index
            return(slabValues[slabInd]);
        }

    }