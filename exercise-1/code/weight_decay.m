function  [non_zero, error] = weight_decay(TrainData, TrainDataTargets, TestData, TestDataTargets, architecture, activation, learn_rate, training, learning)
%d = threshold

%weight decay is an additional term in the weight update rule that causes the weights to exponentially decay to zero, if no other update is scheduled


l=0.1;
d=0.04;

%Process dataset (we havent processed dataset yet)
[TestD, TestDT, TrainD, TrainDT] = preprocess(TestData, TestDataTargets,TrainData, TrainDataTargets);
%create net with initial weight
net = newff(TrainD, TrainDT, architecture);


%number of epochs, activation function, training function, learn rate
net.trainFcn=training;
net.trainParam.epochs=1;
net.layers{2}.transferFcn=activation;
net.biases{2}.learnFcn=learning;
if learn_rate~=0
    net.trainParam.lr=learn_rate;
end
net= train(net,TrainD,TrainDT);


%divide dataset into training and validation set
net.divideParam.trainRatio = 0.8;
net.divideParam.valRatio = 0.2;
net.divideParam.testRatio = 0;

%non_zero=[];
%ms_error=[];

for k = 1:20
       t = getwb(net);
       %Train network for 1 epoch
       [net tr] = train(net, TrainD, TrainDT);
       %Change weights
       new_t = getwb(net) - l*t;
       %Reset weiights w where w<d
       new_t(find(new_t < d))=0;
       %Find non zero weights
       non_zero(k) =nnz(new_t);
	   %find result of simulation for new weights and compare with desired output
	   net_output = sim(net, TestD);
	   %sum(,2) is row sum
	   %error = 1/P * Sum[j=1...P](Sum[i=1...L](dj,i - yj,i)^2) //perceptrons handouts page 8
	   error(k)=sum(sum((TestDT - net_output).^2, 2)) /(size(net_output,1) * size(net_output,2));
       %Update neural network
       net = setwb(net,new_t);
       
end

%[accuracy,precision,recall]=eval_Accuracy_Precision_Recall(net_output,TestDT)

x=1:20;

figure();
subplot(2,1,1)
plot(x, non_zero);
xlabel('Number of epochs');
ylabel('NUmber of nonzero weights');
subplot(2,1,2)
plot(x, error);
xlabel('Number of epochs');
ylabel('Error');
end

