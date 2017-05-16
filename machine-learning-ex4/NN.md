

####logistic regression cost function

$$
J(\theta) = -\frac{1}{m} \sum_{i=1}^m y^{(i)}\log(h_\theta(x^{(i)}) ) +(1-y^{(i)})\log(1-h_\theta(x^{(i)}))
$$

####neural network

$$
J(\Theta) = -\frac{1}{m}[\sum_{i=1}^m\sum_{k=1}^Ky_k^{(i)} \log(h_\Theta(x^{(i)}))_k + (1- y_k^{(i)})\log(1-(h_\Theta(x^{(i)}))_k) ]
$$

#### logistic regression cost function regularization

$$
J(\theta) = -\frac{1}{m} \sum_{i=1}^m y^{(i)}\log(h_\theta(x^{(i)}) ) +(1-y^{(i)})\log(1-h_\theta(x^{(i)})) + \frac{\lambda}{2m} \sum_{j=1}^n \theta_j^2
$$

####neural network regularization

$$
J(\Theta) = -\frac{1}{m}[\sum_{i=1}^m\sum_{k=1}^Ky_k^{(i)} \log(h_\Theta(x^{(i)}))_k + (1- y_k^{(i)})\log(1-(h_\Theta(x^{(i)}))_k)] + \frac{\lambda}{2m} \sum_{l=1}^{L-1}\sum_{i=1}^{s_l}\sum_{j=1}^{s_{l+1}}(\Theta_{ji}^{(l)})^2
$$

#### 代价函数与反向传播 Back propagation

一些标记:

* L 表示神经网络的总层数
* $S_4$表示第四层神经网络，不包括偏差单元`bias unit`
* k表示第几个输出单元



#### Feed forward computation  $h_\theta(x^{(i)})$

![Neural network model.)](C:\Users\nuctang\Desktop\1494568163(1).png)

```matlab
% computation h(x)
% input layerx
a1 = [ones(m,1) X];
% hidden layer
Z2 = a1*Theta1';
a2 = sigmoid(Z2);
a2 = [ones(size(a2,1),1) a2];
% output layer
Z3 = a2*Theta2';
a3 = sigmoid(Z3);
h = a3;
```


$$
J(\Theta) = -\frac{1}{m}[\sum_{i=1}^m\sum_{k=1}^Ky_k^{(i)} \log(h_\Theta(x^{(i)}))_k + (1- y_k^{(i)})\log(1-(h_\Theta(x^{(i)}))_k) ]
$$

```matlab
%case 1
J = 0;
Y = zeros(m,num_labels);
for i = 1 : m
	Y(i,y(i)) = 1;
end
J = -1/m * (Y * log(h)' + (1 - Y) * log(1 - h)');
J = trace(J);


%case 2
J = 0;
Y = zeros(m,num_labels);
for i = 1 : m
	Y(i,y(i)) = 1;
end

for i = 1 : m
	J = J + -1*m *(Y(i,:) * log(h(i,:))' + (1 - Y(i,:)* log(1 - h(i,:))');
end
```





#### back propagation

我们知道代价函数cost function后，下一步就是按照梯度下降法来计算$\theta$求解cost function的最优解。使用梯度下降法首先要求出梯度，即偏导项$\frac{\partial}{\partial \Theta^{(l)} _{ij}} J(\Theta)$，计算偏导项的过程我们称为back propagation。

根据上面的feed forward computation 我们已经计算得到了 $a^{(1)}$ ，$a^{(2)}$， $a^{(3)}$  ，$Z^{(2)}$，$Z^{(3)}$。

在back propagation中，我们定义每层的误差
$$
\delta^{(l)} = \frac {\partial}{ \partial z^{(l)}} J(\Theta)
$$
$\delta^{(l)}_j$ 表示第$l$层第$j$个节点的误差。为了求出偏导项$\frac{\partial}{\partial \Theta^{(l)} _{ij}} J(\Theta)$，我们首先要求出每一层的$\delta$（不包括第一层，第一层是输入层，不存在误差），对于输出层第三层 
$$
\begin{align}
\delta_i^{(4)} & = \frac{\partial}{\partial z_i^{(4)}}J(\Theta) \\
 \\& = \frac{\partial J(\Theta)}{\partial a_i^{(4)}}\frac{\partial a_i^{(4)}}{\partial z_i^{(4)}} \\
 \\& = -\frac{\partial}{\partial a_i^{(4)}}\sum_{k=1}^K\left[y_kloga_k^{(4)}+(1-y_k)log(1-a_k^{(4)})\right]g’(z_i^{(4)})  \\ 
 \\& = -\frac{\partial}{\partial a_i^{(4)}}\left[y_iloga_i^{(4)}+(1-y_i)log(1-a_i^{(4)})\right]g(z_i^{(4)})(1-g(z_i^{(4)}))  \\
\\ & = \left(\frac{1-y_i}{1-a_i^{(4)}}-\frac{y_i}{a_i^{(4)}}\right)a_i^{(4)}(1-a_i^{(4)}) \\ 
\\ & = (1-y_i)a_i^{(4)} - y_i(1-a_i^{(4)}) \\ 
\\ & = a_i^{(4)} - y_i \\ 
\end{align}
$$

$$
\begin{split}
\delta_i^{(l)} & = \frac{\partial}{\partial z_i^{(l)}}J(\Theta) \\ 
\\ & = \sum_{j=1}^{S_j}\frac{\partial J(\Theta)}{\partial z_j^{(l+1)}}\cdot\frac{\partial z_j^{(l+1)}}{\partial a_i^{(l)}}\cdot\frac{\partial a_i^{(l)}}{\partial z_i^{(l)}} \\ \\ & = \sum_{j=1}^{S_j}\delta_j^{(l+1)}\cdot\Theta_{ij}^{(l)}\cdot g’(z_i^{(l)}) \\ 
\\ & = g’(z_i^{(l)})\sum_{j=1}^{S_j}\delta_j^{(l+1)}\cdot\Theta_{ij}^{(l)} 
\end{split}
$$





$$
\begin{split}
\frac{\partial g(z)}{\partial z} & = -\left( \frac{1}{1 + e^{-z}} \right)^2\frac{\partial{}}{\partial{z}} \left(1 + e^{-z} \right) \\
\\ & = -\left( \frac{1}{1 + e^{-z}} \right)^2e^{-z}\left(-1\right) \\ 
\\ & = \left( \frac{1}{1 + e^{-z}} \right) \left( \frac{1}{1 + e^{-z}} \right)\left(e^{-z}\right) \\ 
\\ & = \left( \frac{1}{1 + e^{-z}} \right) \left( \frac{e^{-z}}{1 + e^{-z}} \right) \\ 
\\ & = \left( \frac{1}{1+e^{-z}}\right)\left( \frac{1+e^{-z}}{1+e^{-z}}-\frac{1}{1+e^{-z}}\right) \\
\\ & = g(z) \left( 1 - g(z)\right) \\
\\ \end{split}
$$


$\Theta^{(l)}_{i,j}$ 第$l$层到第$l+1$层的权值矩阵的第$i$行第$j$列的分量

$Z^{(j)}_i$ 第$j$层第$i$个神经元的输入值

$a^{(j)}_i$第$j$层第$i$个神经元的输出值

$a^{(j)} = g(Z^{(j)})$



###### hidden layer to output layer

$$
h_\Theta(x) = a^{(L)} = g(z^{(L)})
$$

$$
z^{(l)} = \Theta^{(l-1)}a^{(l-1)}
$$

$$
\frac{\partial}{\partial \Theta^{(L-1)}_{i,j}}J(\Theta) = \frac {\partial J(\Theta)}{\partial h_\theta(x)_j} \frac{\partial h_\theta(x)_j}{\partial z^{(L)}_i} \frac{\partial z^{(L)}_i}{\partial \Theta^{(L-1)}_{i,j}} = \frac {\partial J(\Theta)}{\partial a^{(L)}_i}\frac{\partial a^{(L)}_i}{\partial z^{(L)}_i} \frac{\partial z^{(L)}_i}{\partial \Theta^{(L-1)}_{i,j}}
$$

$$
cost(\Theta) =- y^{(i)}\log(h_\Theta(x^{(i)}) ) -(1-y^{(i)})\log(1-h_\Theta(x^{(i)}))
$$

$$
\frac{\partial J(\Theta)}{\partial a^{(L)}_i} =\frac{a^{(L)}_i -y_i}{(1-a^{(L)}_i)a^{(L)}_i}
$$

$$
\frac{\partial a^{(L)}_i}{\partial z^{(L)}_i} = \frac{\partial g(z^{(L)}_i)}{\partial z^{(L)}_i} =  g(z^{(L)}_i)(1- g(z^{(L)}_i))=a^{(L)}_i(1- a^{(L)}_i)
$$

$$
\frac{\partial z^{(L)}_j}{\partial \Theta^{(L-1)}_{i,j}} = a^{(L-1)}_i
$$

综上
$$
\begin{split}
\\ \frac{\partial}{\partial \Theta^{(L-1)}_{i,j}}J(\Theta) &= \frac {\partial J(\Theta)}{\partial a^{(L)}_i}\frac{\partial a^{(L)}_i}{\partial z^{(L)}_i} \frac{\partial z^{(L)}_i}{\partial \Theta^{(L-1)}_{i,j}} \\
\\ &=\frac{a^{(L)}_i -y_i}{(1-a^{(L)}_i)a^{(L)}_i} a^{(L)}_i(1- a^{(L)}_i)  a^{(L-1)}_i \\
\\ &= (a^{(L)}_i - y_i) a_j^{(L-1)}
\end{split}
$$


###### hidden layer / input layer  to  hidden layer

$$
\frac{\partial}{\partial \Theta^{(l)}_{i,j}}J(\Theta) = \frac {\partial J(\Theta)}{\partial a^{(l)}_i} \frac{\partial a^{(l)}_i}{\partial z^{(l)}_i}\frac{\partial z^{(l)}_i}{\partial \Theta^{(l)}_{i,j}} \ (l = 1, 2, ..., L-1)
$$





#### Chain Rule

$y = g(x) $    $z = h(y)$

$\Delta x \rightarrow \Delta y \rightarrow \Delta z$     $\frac{dz}{dx} = \frac{dz}{dy} \frac{dy}{dx}$

$x = g(s)$      $y = h(s)$      $z = k(x,y)$

$\frac{dz}{ds} = \frac{\partial z}{\partial x} \frac{dx}{ds} + \frac{\partial z }{\partial y} \frac{dy}{ds}$







​		

![back propagation](C:\Users\nuctang\Desktop\TIM截图20170512155549.png)

```matlab
delta_3 = h - Y;
delta_2 = delta_3 * Theta2 .* a2 .*(1 - a2);
delta_2 = delta_2(:,2:end);

Theta1_grad = delta_2' * a1 / m;
Theta2_grad = delta_3' * a2 / m
```



#### Chain Rule

$y = g(x) $    $z = h(y)$

$\Delta x \rightarrow \Delta y \rightarrow \Delta z$     $\frac{dz}{dx} = \frac{dz}{dy} \frac{dy}{dx}$

$x = g(s)$      $y = h(s)$      $z = k(x,y)$

$\frac{dz}{ds} = \frac{\partial z}{\partial x} \frac{dx}{ds} + \frac{\partial z }{\partial y} \frac{dy}{ds}$



​																																																																																																																																																																																																						