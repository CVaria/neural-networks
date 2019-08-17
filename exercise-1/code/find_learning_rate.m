%Step 6e
function [best_training, best_rate ,max_accuracy] = find_learning_rate( TrainData, TrainDataTargets, TestData, TestDataTargets, architecture)
   
    [TestD, TestDT, TrainD, TrainDT] = preprocess(TestData, TestDataTargets, TrainData, TrainDataTargets);

	acc_gd=[];
	prec_gd=[];
	rec_gd=[];
    acc_gdx=[];
    prec_gdx=[];
    rec_gdx=[];
	k=1;
    
    for i=0.05:0.05:0.4
        %test traingd 
        net1 = newff(TrainD, TrainDT, architecture);
    
        %suitable activation function 
        net1.trainFcn = 'traingd';
			
        %divide dataset into training and validation set
        net1.divideParam.trainRatio=0.8;
        net1.divideParam.valRatio=0.2;
        net1.divideParam.testRatio=0;
        net1.trainParam.epochs=150000;
    
        %Learning Rate
        net1.trainParam.lr =i;
	
        net1=train(net1,TrainD,TrainDT);
            
        %evaluate network
        TestDataOutput = sim(net1, TestD);
     
        [acc_gd(k), prec_gd(k,:), rec_gd(k,:)] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDT);
        k=k+1;
    end
    
    
    acc_gd
    prec_gd
    rec_gd
  
   [max_gd,Index_gd] = max(acc_gd(:))
    
    k=1;
    
    for i=0.05:0.05:0.4
        %test  traingdx
        net2 = newff(TrainD, TrainDT, architecture);
    
        %suitable activation function 
        net2.trainFcn = 'traingdx';
			
        %divide dataset into training and validation set
        net2.divideParam.trainRatio=0.8;
        net2.divideParam.valRatio=0.2;
        net2.divideParam.testRatio=0;
        net2.trainParam.epochs=1000;
        
        %Learning Rate
        %net2.trainParam.lr =i;
	
        net2=train(net2,TrainD,TrainDT);
            
        %evaluate network
        TestDataOutput = sim(net2, TestD);
     
        [acc_gdx(k), prec_gdx(k,:), rec_gdx(k,:)] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDT);
        k=k+1;
    end
 
    acc_gdx
    prec_gdx
   rec_gdx
    
    
   [max_gdx,Index_gdx] = max(acc_gdx(:))
    
    if max_gdx > max_gd
        best_training = 'traingdx';
        best_rate = 0.05 * Index_gdx;
        max_accuracy = max_gdx;
    else
        best_training = 'traingd';
        best_rate = 0.05 * Index_gd;
        max_accuracy = max_gd;
    end  
    
    
    
    %just some plots
    
    rate=0.05:0.05:0.4;
    figure();
    bar(rate,acc_gdx);
    title('Accuracies based on learning rates with traingdx');
    xlabel('Ratio');
    ylabel('Accuracy');

    figure();
    bar(rate,prec_gdx);
    title('Precisions based on learning rates with traingdx');
    xlabel('Ratio');
    ylabel('Precision');

    figure();
    bar(rate,rec_gdx);
    title('Recalls based on learning rates with traingdx');
    xlabel('Ratio');
    ylabel('Recall');

    figure();
    bar(rate,acc_gd);
    title('Accuracies based on learning rates with traingd');
    xlabel('Ratio');
    ylabel('Accuracy');

    figure();
    bar(rate,prec_gd);
    title('Precisions based on learning rates with traingd');
    xlabel('Ratio');
    ylabel('Precision');

    figure();
    bar(rate,rec_gd);
    title('Recalls based on learning rates with traingd');
    xlabel('Ratio');
    ylabel('Recall');
    
  
 end