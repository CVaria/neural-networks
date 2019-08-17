function DocProcess(Patterns,titles, terms, IW, distances, N, gridSize)

 new_P = full(tfidf1(Patterns));
 %new_Patterns =>dimensions 8296 x 500
 new_Patterns = new_P.';

%4Gi)find how many documents each node has - OUT OF MEMORY ERROR
%number_of_docs=[];

%x = negdist(IW, new_Patterns)
%output_docs = compet(x)
%x = x.';
%output_docs2 = compet(x);

%for i=1:N
%    number_of_docs(i) = sum(output_docs(i,:));
%end
%fprintf('\n Question 4G (i) Number of Documents\n') 
%number_of_docs

%second way to find 4Gi

number_of_docs= zeros(N,1);
P = size(new_Patterns, 2);

for j = 1:P
    out =somOutput(new_Patterns(:,j));
    winner_pos = find(out);
    number_of_docs(winner_pos) = number_of_docs(winner_pos)+1;
end

fprintf('\n Question 4G (i) results verification\n')
number_of_docs

%4Gii)find document/title with closest distance for each node
min_dist_index=[];
min_dist_title = cell(N,1);

x=[]
for j = 1:P
    x = [x negdist(IW, new_Patterns(:,j))];
end

fprintf('second ok\n')
size(x,1)
size(x,2)

x2 = x.';
output_docs2 = compet(x2);

for i = 1:N
    min_dist_index(i) = find(output_docs2(:,i),1); 
    min_dist_title(i) = [titles(min_dist_index(i))];
end

fprintf('\n Question 4G (ii) Titles\n')
min_dist_title

%4Giii)find first 3 terms with higher weight for each node
max_weight_indexes=[];
max_weight_terms=cell(N,3);

[sorted_weights, Indexes] = sort(IW, 2, 'descend');

for i = 1:N
    
    max_weight_indexes(i,:) = Indexes(i,1:3);
    max_weight_terms(i,:) = [terms(Indexes(i,1)) terms(Indexes(i,2)) terms(Indexes(i,3))];
    
end

fprintf('\n Question 4G (iii) Indexes and Results\n')
max_weight_indexes
max_weight_terms



%4Giv) Find nodes with weigth > 0.3 * max_weight for terms 'network' and 'function'
%network has index (1,1) and function has index (7,1)
max_weight = max (IW(:))
nodes=[];
max_weight_network = max(IW(:,1))
max_weight_function= max(IW(:,7))

%IW(:,1) > (0.001*max_weight) & IW(:,7) >(0.001*max_weight)

for i =1 :N
    if IW(i,1) > (0.3*max_weight) & IW(i,7) >(0.3*max_weight)
        nodes = [nodes i];
    end
end

fprintf('\n Question 4G (iv)\n Neurons')
nodes

%4Gv)find mean value of terms for each node of (4Giv)
fprintf('\n Question 4G (v) Mean Value of terms \n')
node_weights=[];
for i=1:size(nodes,2)
    node_weights(i,:) = IW(nodes(i),:);
end

node_weights

mean_terms = mean(node_weights,1)
perc = (mean_terms./ max_weight) *100

figure; 
plot2DSomData(IW, distances,new_Patterns)
figure;
somShow(IW,gridSize)

save('doc4_process.mat')