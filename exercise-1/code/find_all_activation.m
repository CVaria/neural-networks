%Step 6a
function [accuracy, precision, recall]= find_all_activation( TrainData, TrainDataTargets, TestData, TestDataTargets, architecture, training)
    [TestD, TestDT, TrainD, TrainDT] = preprocess(TestData, TestDataTargets, TrainData, TrainDataTargets);
   
	accuracy=[];
	precision=[];
	recall=[];
	
	%activation  choices: hardlim, tansig, logsig, purelin
	activ={'hardlim', 'tansig', 'logsig', 'purelin'};
    
    for i=1:4
        %create neural network with suitable architecture
        net = newff(TrainD, TrainDT, architecture); 
        
        %set given training and activation function 
        net.trainFcn = training;
        %thats only for output layer, default for hidden layers is 'tansig'
        net.layers{2}.transferFcn=activ{i};
			
        %divide dataset into training and validation set
        net.divideParam.trainRatio=0.8;
        net.divideParam.valRatio=0.2;
        net.divideParam.testRatio=0;
        net.trainParam.epochs=1000;
    
        net=train(net,TrainD,TrainDT);
            
        %evaluate network
        TestDataOutput = sim(net, TestD);
     
        [accuracy(i), precision(i,:), recall(i,:)] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDT);
    end
    
    
    figure();
    bar(accuracy);
    title('Accuracies based on activation functions');
    xlabel('Activation Functions');
    ylabel('Accuracy');
    %labs={'hardlim','tansig','logsig','purelin'};
    set(gca,'XTick',1:4,'xticklabels',activ);
    
    
    figure();
    bar(precision);
    title('Precisions based on activation functions');
    xlabel('Activation Functions');
    ylabel('Precision');
    %labs={'hardlim','tansig','logsig','purelin'};
    set(gca,'XTick',1:4,'xticklabels',activ)
    
    figure();
    bar(recall);
    title('Recalls based on activation functions');
    xlabel('Activation Functions');
    ylabel('Recall');
    %labs={'hardlim','tansig','logsig','purelin'};
    set(gca,'XTick',1:4,'xticklabels',activ)
 

 end