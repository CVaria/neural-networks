%Step 6d
function [best_epoch,max_accuracy] = find_epoch_rate( TrainData, TrainDataTargets, TestData, TestDataTargets, architecture, training, k)
    
    [TestD, TestDT, TrainD, TrainDT] = preprocess(TestData, TestDataTargets, TrainData, TrainDataTargets);

	acc_val=[];
	prec_val=[];
	rec_val=[];
	acc_epoch=[];
	prec_epoch=[];
	rec_epoch=[];
	
	
    number_of_epochs=0;
    
    %test performance with validate set to find the number of epochs it
    %stopped
    net1 = newff(TrainD, TrainDT, architecture);
    
    %set given training function 
    net1.trainFcn = training;
			
	%divide dataset into training and validation set
	net1.divideParam.trainRatio=0.8;
	net1.divideParam.valRatio=0.2;
	net1.divideParam.testRatio=0;
	%net1.trainParam.epochs=1000;
	
    [net1, tr]=train(net1,TrainD,TrainDT);
            
    number_of_epochs = tr.num_epochs
	%evaluate network
	TestDataOutput = sim(net1, TestD);
     
	[acc_val, prec_val, rec_val] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDT)
		
    
    max_accuracy_epoch=0;
	ep=number_of_epochs; 
    
    for i=(ep-k):(ep+k)  
    
	
        %test performance without validation set
        net2 = newff(TrainD, TrainDT, architecture);
    
        %set given activation function 
        net2.trainFcn = training;
			
        %divide dataset into training and validation set
        net2.divideParam.trainRatio=1;
        net2.divideParam.valRatio=0;
        net2.divideParam.testRatio=0;
        net2.trainParam.epochs=i;
	
        net2=train(net2,TrainD,TrainDT);
        %evaluate network
        TestDataOutput = sim(net2, TestD);
	
        [acc_epoch(i-ep+k+1),prec_epoch(i-ep+k+1,:),rec_epoch(i-ep+k+1,:)]=eval_Accuracy_Precision_Recall(TestDataOutput, TestDT);
   
    end
    
    
    acc_epoch
    prec_epoch
    rec_epoch
    
    [max_accuracy, Index_epoch] = max(acc_epoch(:))
 
    best_epoch = Index_epoch + number_of_epochs -k-1;
    
    %test plot
    figure();
    x=number_of_epochs-k:number_of_epochs+k;
    bar(x,acc_epoch);
    title('Accuracies without Validation Set');
    ylabel('Accuracy');
    xlabel('Number of Epochs');
  
 end