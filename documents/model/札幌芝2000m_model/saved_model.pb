��
��
B
AssignVariableOp
resource
value"dtype"
dtypetype�
~
BiasAdd

value"T	
bias"T
output"T" 
Ttype:
2	"-
data_formatstringNHWC:
NHWCNCHW
8
Const
output"dtype"
valuetensor"
dtypetype
.
Identity

input"T
output"T"	
Ttype
\
	LeakyRelu
features"T
activations"T"
alphafloat%��L>"
Ttype0:
2
q
MatMul
a"T
b"T
product"T"
transpose_abool( "
transpose_bbool( "
Ttype:

2	
e
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(�

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
@
ReadVariableOp
resource
value"dtype"
dtypetype�
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0�
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0�
?
Select
	condition

t"T
e"T
output"T"	
Ttype
H
ShardedFilename
basename	
shard

num_shards
filename
0
Sigmoid
x"T
y"T"
Ttype:

2
�
StatefulPartitionedCall
args2Tin
output2Tout"
Tin
list(type)("
Tout
list(type)("	
ffunc"
configstring "
config_protostring "
executor_typestring �
@
StaticRegexFullMatch	
input

output
"
patternstring
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
<
Sub
x"T
y"T
z"T"
Ttype:
2	
�
VarHandleOp
resource"
	containerstring "
shared_namestring "
dtypetype"
shapeshape"#
allowed_deviceslist(string)
 �"serve*2.6.02v2.6.0-rc2-32-g919f693420e8ז
�
rank_net_16/dense_50/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:*,
shared_namerank_net_16/dense_50/kernel
�
/rank_net_16/dense_50/kernel/Read/ReadVariableOpReadVariableOprank_net_16/dense_50/kernel*
_output_shapes

:*
dtype0
�
rank_net_16/dense_50/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape:**
shared_namerank_net_16/dense_50/bias
�
-rank_net_16/dense_50/bias/Read/ReadVariableOpReadVariableOprank_net_16/dense_50/bias*
_output_shapes
:*
dtype0
d
SGD/iterVarHandleOp*
_output_shapes
: *
dtype0	*
shape: *
shared_name
SGD/iter
]
SGD/iter/Read/ReadVariableOpReadVariableOpSGD/iter*
_output_shapes
: *
dtype0	
f
	SGD/decayVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_name	SGD/decay
_
SGD/decay/Read/ReadVariableOpReadVariableOp	SGD/decay*
_output_shapes
: *
dtype0
v
SGD/learning_rateVarHandleOp*
_output_shapes
: *
dtype0*
shape: *"
shared_nameSGD/learning_rate
o
%SGD/learning_rate/Read/ReadVariableOpReadVariableOpSGD/learning_rate*
_output_shapes
: *
dtype0
l
SGD/momentumVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_nameSGD/momentum
e
 SGD/momentum/Read/ReadVariableOpReadVariableOpSGD/momentum*
_output_shapes
: *
dtype0
�
rank_net_16/dense_48/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:*,
shared_namerank_net_16/dense_48/kernel
�
/rank_net_16/dense_48/kernel/Read/ReadVariableOpReadVariableOprank_net_16/dense_48/kernel*
_output_shapes

:*
dtype0
�
rank_net_16/dense_48/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape:**
shared_namerank_net_16/dense_48/bias
�
-rank_net_16/dense_48/bias/Read/ReadVariableOpReadVariableOprank_net_16/dense_48/bias*
_output_shapes
:*
dtype0
�
rank_net_16/dense_49/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:*,
shared_namerank_net_16/dense_49/kernel
�
/rank_net_16/dense_49/kernel/Read/ReadVariableOpReadVariableOprank_net_16/dense_49/kernel*
_output_shapes

:*
dtype0
�
rank_net_16/dense_49/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape:**
shared_namerank_net_16/dense_49/bias
�
-rank_net_16/dense_49/bias/Read/ReadVariableOpReadVariableOprank_net_16/dense_49/bias*
_output_shapes
:*
dtype0
^
totalVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_nametotal
W
total/Read/ReadVariableOpReadVariableOptotal*
_output_shapes
: *
dtype0
^
countVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_namecount
W
count/Read/ReadVariableOpReadVariableOpcount*
_output_shapes
: *
dtype0
b
total_1VarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_name	total_1
[
total_1/Read/ReadVariableOpReadVariableOptotal_1*
_output_shapes
: *
dtype0
b
count_1VarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_name	count_1
[
count_1/Read/ReadVariableOpReadVariableOpcount_1*
_output_shapes
: *
dtype0

NoOpNoOp
�
ConstConst"/device:CPU:0*
_output_shapes
: *
dtype0*�
value�B� B�
�
	dense
o
oi_minus_oj
	optimizer
trainable_variables
regularization_losses
	variables
	keras_api
	
signatures


0
1
h

kernel
bias
trainable_variables
regularization_losses
	variables
	keras_api
R
trainable_variables
regularization_losses
	variables
	keras_api
6
iter
	decay
learning_rate
momentum
*
0
1
2
3
4
5
 
*
0
1
2
3
4
5
�
non_trainable_variables
metrics
trainable_variables
 layer_regularization_losses
!layer_metrics

"layers
regularization_losses
	variables
 
h

kernel
bias
#trainable_variables
$regularization_losses
%	variables
&	keras_api
h

kernel
bias
'trainable_variables
(regularization_losses
)	variables
*	keras_api
TR
VARIABLE_VALUErank_net_16/dense_50/kernel#o/kernel/.ATTRIBUTES/VARIABLE_VALUE
PN
VARIABLE_VALUErank_net_16/dense_50/bias!o/bias/.ATTRIBUTES/VARIABLE_VALUE

0
1
 

0
1
�
+non_trainable_variables
,metrics
trainable_variables
-layer_regularization_losses
.layer_metrics

/layers
regularization_losses
	variables
 
 
 
�
0non_trainable_variables
1metrics
trainable_variables
2layer_regularization_losses
3layer_metrics

4layers
regularization_losses
	variables
GE
VARIABLE_VALUESGD/iter)optimizer/iter/.ATTRIBUTES/VARIABLE_VALUE
IG
VARIABLE_VALUE	SGD/decay*optimizer/decay/.ATTRIBUTES/VARIABLE_VALUE
YW
VARIABLE_VALUESGD/learning_rate2optimizer/learning_rate/.ATTRIBUTES/VARIABLE_VALUE
OM
VARIABLE_VALUESGD/momentum-optimizer/momentum/.ATTRIBUTES/VARIABLE_VALUE
a_
VARIABLE_VALUErank_net_16/dense_48/kernel0trainable_variables/0/.ATTRIBUTES/VARIABLE_VALUE
_]
VARIABLE_VALUErank_net_16/dense_48/bias0trainable_variables/1/.ATTRIBUTES/VARIABLE_VALUE
a_
VARIABLE_VALUErank_net_16/dense_49/kernel0trainable_variables/2/.ATTRIBUTES/VARIABLE_VALUE
_]
VARIABLE_VALUErank_net_16/dense_49/bias0trainable_variables/3/.ATTRIBUTES/VARIABLE_VALUE
 

50
61
 
 


0
1
2
3

0
1
 

0
1
�
7non_trainable_variables
8metrics
#trainable_variables
9layer_regularization_losses
:layer_metrics

;layers
$regularization_losses
%	variables

0
1
 

0
1
�
<non_trainable_variables
=metrics
'trainable_variables
>layer_regularization_losses
?layer_metrics

@layers
(regularization_losses
)	variables
 
 
 
 
 
 
 
 
 
 
4
	Atotal
	Bcount
C	variables
D	keras_api
D
	Etotal
	Fcount
G
_fn_kwargs
H	variables
I	keras_api
 
 
 
 
 
 
 
 
 
 
OM
VARIABLE_VALUEtotal4keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUE
OM
VARIABLE_VALUEcount4keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUE

A0
B1

C	variables
QO
VARIABLE_VALUEtotal_14keras_api/metrics/1/total/.ATTRIBUTES/VARIABLE_VALUE
QO
VARIABLE_VALUEcount_14keras_api/metrics/1/count/.ATTRIBUTES/VARIABLE_VALUE
 

E0
F1

H	variables
z
serving_default_input_1Placeholder*'
_output_shapes
:���������*
dtype0*
shape:���������
z
serving_default_input_2Placeholder*'
_output_shapes
:���������*
dtype0*
shape:���������
�
StatefulPartitionedCallStatefulPartitionedCallserving_default_input_1serving_default_input_2rank_net_16/dense_48/kernelrank_net_16/dense_48/biasrank_net_16/dense_49/kernelrank_net_16/dense_49/biasrank_net_16/dense_50/kernelrank_net_16/dense_50/bias*
Tin

2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*(
_read_only_resource_inputs

*-
config_proto

CPU

GPU 2J 8� *.
f)R'
%__inference_signature_wrapper_1861018
O
saver_filenamePlaceholder*
_output_shapes
: *
dtype0*
shape: 
�
StatefulPartitionedCall_1StatefulPartitionedCallsaver_filename/rank_net_16/dense_50/kernel/Read/ReadVariableOp-rank_net_16/dense_50/bias/Read/ReadVariableOpSGD/iter/Read/ReadVariableOpSGD/decay/Read/ReadVariableOp%SGD/learning_rate/Read/ReadVariableOp SGD/momentum/Read/ReadVariableOp/rank_net_16/dense_48/kernel/Read/ReadVariableOp-rank_net_16/dense_48/bias/Read/ReadVariableOp/rank_net_16/dense_49/kernel/Read/ReadVariableOp-rank_net_16/dense_49/bias/Read/ReadVariableOptotal/Read/ReadVariableOpcount/Read/ReadVariableOptotal_1/Read/ReadVariableOpcount_1/Read/ReadVariableOpConst*
Tin
2	*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *)
f$R"
 __inference__traced_save_1861273
�
StatefulPartitionedCall_2StatefulPartitionedCallsaver_filenamerank_net_16/dense_50/kernelrank_net_16/dense_50/biasSGD/iter	SGD/decaySGD/learning_rateSGD/momentumrank_net_16/dense_48/kernelrank_net_16/dense_48/biasrank_net_16/dense_49/kernelrank_net_16/dense_49/biastotalcounttotal_1count_1*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *,
f'R%
#__inference__traced_restore_1861325��
�
r
H__inference_subtract_16_layer_call_and_return_conditional_losses_1860889

inputs
inputs_1
identityU
subSubinputsinputs_1*
T0*'
_output_shapes
:���������2
sub[
IdentityIdentitysub:z:0*
T0*'
_output_shapes
:���������2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*9
_input_shapes(
&:���������:���������:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs:OK
'
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
E__inference_dense_49_layer_call_and_return_conditional_losses_1861207

inputs0
matmul_readvariableop_resource:-
biasadd_readvariableop_resource:
identity��BiasAdd/ReadVariableOp�MatMul/ReadVariableOp�
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:*
dtype02
MatMul/ReadVariableOps
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
MatMul�
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype02
BiasAdd/ReadVariableOp�
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2	
BiasAdd^
	LeakyRelu	LeakyReluBiasAdd:output:0*'
_output_shapes
:���������2
	LeakyRelur
IdentityIdentityLeakyRelu:activations:0^NoOp*
T0*'
_output_shapes
:���������2

Identity
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:���������: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
E__inference_dense_49_layer_call_and_return_conditional_losses_1860855

inputs0
matmul_readvariableop_resource:-
biasadd_readvariableop_resource:
identity��BiasAdd/ReadVariableOp�MatMul/ReadVariableOp�
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:*
dtype02
MatMul/ReadVariableOps
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
MatMul�
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype02
BiasAdd/ReadVariableOp�
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2	
BiasAdd^
	LeakyRelu	LeakyReluBiasAdd:output:0*'
_output_shapes
:���������2
	LeakyRelur
IdentityIdentityLeakyRelu:activations:0^NoOp*
T0*'
_output_shapes
:���������2

Identity
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:���������: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs
�

�
-__inference_rank_net_16_layer_call_fn_1861036
input_1
input_2
unknown:
	unknown_0:
	unknown_1:
	unknown_2:
	unknown_3:
	unknown_4:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinput_1input_2unknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4*
Tin

2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*(
_read_only_resource_inputs

*-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_rank_net_16_layer_call_and_return_conditional_losses_18608932
StatefulPartitionedCall{
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:���������2

Identityh
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*E
_input_shapes4
2:���������:���������: : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:P L
'
_output_shapes
:���������
!
_user_specified_name	input_1:PL
'
_output_shapes
:���������
!
_user_specified_name	input_2
�H
�
"__inference__wrapped_model_1860815
input_1
input_2E
3rank_net_16_dense_48_matmul_readvariableop_resource:B
4rank_net_16_dense_48_biasadd_readvariableop_resource:E
3rank_net_16_dense_49_matmul_readvariableop_resource:B
4rank_net_16_dense_49_biasadd_readvariableop_resource:E
3rank_net_16_dense_50_matmul_readvariableop_resource:B
4rank_net_16_dense_50_biasadd_readvariableop_resource:
identity��+rank_net_16/dense_48/BiasAdd/ReadVariableOp�-rank_net_16/dense_48/BiasAdd_1/ReadVariableOp�*rank_net_16/dense_48/MatMul/ReadVariableOp�,rank_net_16/dense_48/MatMul_1/ReadVariableOp�+rank_net_16/dense_49/BiasAdd/ReadVariableOp�-rank_net_16/dense_49/BiasAdd_1/ReadVariableOp�*rank_net_16/dense_49/MatMul/ReadVariableOp�,rank_net_16/dense_49/MatMul_1/ReadVariableOp�+rank_net_16/dense_50/BiasAdd/ReadVariableOp�-rank_net_16/dense_50/BiasAdd_1/ReadVariableOp�*rank_net_16/dense_50/MatMul/ReadVariableOp�,rank_net_16/dense_50/MatMul_1/ReadVariableOp�
*rank_net_16/dense_48/MatMul/ReadVariableOpReadVariableOp3rank_net_16_dense_48_matmul_readvariableop_resource*
_output_shapes

:*
dtype02,
*rank_net_16/dense_48/MatMul/ReadVariableOp�
rank_net_16/dense_48/MatMulMatMulinput_12rank_net_16/dense_48/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
rank_net_16/dense_48/MatMul�
+rank_net_16/dense_48/BiasAdd/ReadVariableOpReadVariableOp4rank_net_16_dense_48_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02-
+rank_net_16/dense_48/BiasAdd/ReadVariableOp�
rank_net_16/dense_48/BiasAddBiasAdd%rank_net_16/dense_48/MatMul:product:03rank_net_16/dense_48/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
rank_net_16/dense_48/BiasAdd�
rank_net_16/dense_48/LeakyRelu	LeakyRelu%rank_net_16/dense_48/BiasAdd:output:0*'
_output_shapes
:���������2 
rank_net_16/dense_48/LeakyRelu�
,rank_net_16/dense_48/MatMul_1/ReadVariableOpReadVariableOp3rank_net_16_dense_48_matmul_readvariableop_resource*
_output_shapes

:*
dtype02.
,rank_net_16/dense_48/MatMul_1/ReadVariableOp�
rank_net_16/dense_48/MatMul_1MatMulinput_24rank_net_16/dense_48/MatMul_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
rank_net_16/dense_48/MatMul_1�
-rank_net_16/dense_48/BiasAdd_1/ReadVariableOpReadVariableOp4rank_net_16_dense_48_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02/
-rank_net_16/dense_48/BiasAdd_1/ReadVariableOp�
rank_net_16/dense_48/BiasAdd_1BiasAdd'rank_net_16/dense_48/MatMul_1:product:05rank_net_16/dense_48/BiasAdd_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2 
rank_net_16/dense_48/BiasAdd_1�
 rank_net_16/dense_48/LeakyRelu_1	LeakyRelu'rank_net_16/dense_48/BiasAdd_1:output:0*'
_output_shapes
:���������2"
 rank_net_16/dense_48/LeakyRelu_1�
*rank_net_16/dense_49/MatMul/ReadVariableOpReadVariableOp3rank_net_16_dense_49_matmul_readvariableop_resource*
_output_shapes

:*
dtype02,
*rank_net_16/dense_49/MatMul/ReadVariableOp�
rank_net_16/dense_49/MatMulMatMul,rank_net_16/dense_48/LeakyRelu:activations:02rank_net_16/dense_49/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
rank_net_16/dense_49/MatMul�
+rank_net_16/dense_49/BiasAdd/ReadVariableOpReadVariableOp4rank_net_16_dense_49_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02-
+rank_net_16/dense_49/BiasAdd/ReadVariableOp�
rank_net_16/dense_49/BiasAddBiasAdd%rank_net_16/dense_49/MatMul:product:03rank_net_16/dense_49/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
rank_net_16/dense_49/BiasAdd�
rank_net_16/dense_49/LeakyRelu	LeakyRelu%rank_net_16/dense_49/BiasAdd:output:0*'
_output_shapes
:���������2 
rank_net_16/dense_49/LeakyRelu�
,rank_net_16/dense_49/MatMul_1/ReadVariableOpReadVariableOp3rank_net_16_dense_49_matmul_readvariableop_resource*
_output_shapes

:*
dtype02.
,rank_net_16/dense_49/MatMul_1/ReadVariableOp�
rank_net_16/dense_49/MatMul_1MatMul.rank_net_16/dense_48/LeakyRelu_1:activations:04rank_net_16/dense_49/MatMul_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
rank_net_16/dense_49/MatMul_1�
-rank_net_16/dense_49/BiasAdd_1/ReadVariableOpReadVariableOp4rank_net_16_dense_49_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02/
-rank_net_16/dense_49/BiasAdd_1/ReadVariableOp�
rank_net_16/dense_49/BiasAdd_1BiasAdd'rank_net_16/dense_49/MatMul_1:product:05rank_net_16/dense_49/BiasAdd_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2 
rank_net_16/dense_49/BiasAdd_1�
 rank_net_16/dense_49/LeakyRelu_1	LeakyRelu'rank_net_16/dense_49/BiasAdd_1:output:0*'
_output_shapes
:���������2"
 rank_net_16/dense_49/LeakyRelu_1�
*rank_net_16/dense_50/MatMul/ReadVariableOpReadVariableOp3rank_net_16_dense_50_matmul_readvariableop_resource*
_output_shapes

:*
dtype02,
*rank_net_16/dense_50/MatMul/ReadVariableOp�
rank_net_16/dense_50/MatMulMatMul,rank_net_16/dense_49/LeakyRelu:activations:02rank_net_16/dense_50/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
rank_net_16/dense_50/MatMul�
+rank_net_16/dense_50/BiasAdd/ReadVariableOpReadVariableOp4rank_net_16_dense_50_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02-
+rank_net_16/dense_50/BiasAdd/ReadVariableOp�
rank_net_16/dense_50/BiasAddBiasAdd%rank_net_16/dense_50/MatMul:product:03rank_net_16/dense_50/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
rank_net_16/dense_50/BiasAdd�
,rank_net_16/dense_50/MatMul_1/ReadVariableOpReadVariableOp3rank_net_16_dense_50_matmul_readvariableop_resource*
_output_shapes

:*
dtype02.
,rank_net_16/dense_50/MatMul_1/ReadVariableOp�
rank_net_16/dense_50/MatMul_1MatMul.rank_net_16/dense_49/LeakyRelu_1:activations:04rank_net_16/dense_50/MatMul_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
rank_net_16/dense_50/MatMul_1�
-rank_net_16/dense_50/BiasAdd_1/ReadVariableOpReadVariableOp4rank_net_16_dense_50_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02/
-rank_net_16/dense_50/BiasAdd_1/ReadVariableOp�
rank_net_16/dense_50/BiasAdd_1BiasAdd'rank_net_16/dense_50/MatMul_1:product:05rank_net_16/dense_50/BiasAdd_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2 
rank_net_16/dense_50/BiasAdd_1�
rank_net_16/subtract_16/subSub%rank_net_16/dense_50/BiasAdd:output:0'rank_net_16/dense_50/BiasAdd_1:output:0*
T0*'
_output_shapes
:���������2
rank_net_16/subtract_16/sub�
rank_net_16/activation/SigmoidSigmoidrank_net_16/subtract_16/sub:z:0*
T0*'
_output_shapes
:���������2 
rank_net_16/activation/Sigmoid}
IdentityIdentity"rank_net_16/activation/Sigmoid:y:0^NoOp*
T0*'
_output_shapes
:���������2

Identity�
NoOpNoOp,^rank_net_16/dense_48/BiasAdd/ReadVariableOp.^rank_net_16/dense_48/BiasAdd_1/ReadVariableOp+^rank_net_16/dense_48/MatMul/ReadVariableOp-^rank_net_16/dense_48/MatMul_1/ReadVariableOp,^rank_net_16/dense_49/BiasAdd/ReadVariableOp.^rank_net_16/dense_49/BiasAdd_1/ReadVariableOp+^rank_net_16/dense_49/MatMul/ReadVariableOp-^rank_net_16/dense_49/MatMul_1/ReadVariableOp,^rank_net_16/dense_50/BiasAdd/ReadVariableOp.^rank_net_16/dense_50/BiasAdd_1/ReadVariableOp+^rank_net_16/dense_50/MatMul/ReadVariableOp-^rank_net_16/dense_50/MatMul_1/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*E
_input_shapes4
2:���������:���������: : : : : : 2Z
+rank_net_16/dense_48/BiasAdd/ReadVariableOp+rank_net_16/dense_48/BiasAdd/ReadVariableOp2^
-rank_net_16/dense_48/BiasAdd_1/ReadVariableOp-rank_net_16/dense_48/BiasAdd_1/ReadVariableOp2X
*rank_net_16/dense_48/MatMul/ReadVariableOp*rank_net_16/dense_48/MatMul/ReadVariableOp2\
,rank_net_16/dense_48/MatMul_1/ReadVariableOp,rank_net_16/dense_48/MatMul_1/ReadVariableOp2Z
+rank_net_16/dense_49/BiasAdd/ReadVariableOp+rank_net_16/dense_49/BiasAdd/ReadVariableOp2^
-rank_net_16/dense_49/BiasAdd_1/ReadVariableOp-rank_net_16/dense_49/BiasAdd_1/ReadVariableOp2X
*rank_net_16/dense_49/MatMul/ReadVariableOp*rank_net_16/dense_49/MatMul/ReadVariableOp2\
,rank_net_16/dense_49/MatMul_1/ReadVariableOp,rank_net_16/dense_49/MatMul_1/ReadVariableOp2Z
+rank_net_16/dense_50/BiasAdd/ReadVariableOp+rank_net_16/dense_50/BiasAdd/ReadVariableOp2^
-rank_net_16/dense_50/BiasAdd_1/ReadVariableOp-rank_net_16/dense_50/BiasAdd_1/ReadVariableOp2X
*rank_net_16/dense_50/MatMul/ReadVariableOp*rank_net_16/dense_50/MatMul/ReadVariableOp2\
,rank_net_16/dense_50/MatMul_1/ReadVariableOp,rank_net_16/dense_50/MatMul_1/ReadVariableOp:P L
'
_output_shapes
:���������
!
_user_specified_name	input_1:PL
'
_output_shapes
:���������
!
_user_specified_name	input_2
�

�
E__inference_dense_50_layer_call_and_return_conditional_losses_1860874

inputs0
matmul_readvariableop_resource:-
biasadd_readvariableop_resource:
identity��BiasAdd/ReadVariableOp�MatMul/ReadVariableOp�
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:*
dtype02
MatMul/ReadVariableOps
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
MatMul�
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype02
BiasAdd/ReadVariableOp�
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2	
BiasAddk
IdentityIdentityBiasAdd:output:0^NoOp*
T0*'
_output_shapes
:���������2

Identity
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:���������: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
*__inference_dense_48_layer_call_fn_1861176

inputs
unknown:
	unknown_0:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_dense_48_layer_call_and_return_conditional_losses_18608352
StatefulPartitionedCall{
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:���������2

Identityh
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:���������: : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs
�	
�
%__inference_signature_wrapper_1861018
input_1
input_2
unknown:
	unknown_0:
	unknown_1:
	unknown_2:
	unknown_3:
	unknown_4:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinput_1input_2unknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4*
Tin

2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*(
_read_only_resource_inputs

*-
config_proto

CPU

GPU 2J 8� *+
f&R$
"__inference__wrapped_model_18608152
StatefulPartitionedCall{
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:���������2

Identityh
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*E
_input_shapes4
2:���������:���������: : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:P L
'
_output_shapes
:���������
!
_user_specified_name	input_1:PL
'
_output_shapes
:���������
!
_user_specified_name	input_2
�
�
*__inference_dense_49_layer_call_fn_1861196

inputs
unknown:
	unknown_0:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_dense_49_layer_call_and_return_conditional_losses_18608552
StatefulPartitionedCall{
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:���������2

Identityh
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:���������: : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs
�

�
E__inference_dense_50_layer_call_and_return_conditional_losses_1861155

inputs0
matmul_readvariableop_resource:-
biasadd_readvariableop_resource:
identity��BiasAdd/ReadVariableOp�MatMul/ReadVariableOp�
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:*
dtype02
MatMul/ReadVariableOps
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
MatMul�
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype02
BiasAdd/ReadVariableOp�
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2	
BiasAddk
IdentityIdentityBiasAdd:output:0^NoOp*
T0*'
_output_shapes
:���������2

Identity
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:���������: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs
�

�
-__inference_rank_net_16_layer_call_fn_1861054
inputs_0
inputs_1
unknown:
	unknown_0:
	unknown_1:
	unknown_2:
	unknown_3:
	unknown_4:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputs_0inputs_1unknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4*
Tin

2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*(
_read_only_resource_inputs

*-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_rank_net_16_layer_call_and_return_conditional_losses_18608932
StatefulPartitionedCall{
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:���������2

Identityh
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*E
_input_shapes4
2:���������:���������: : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:Q M
'
_output_shapes
:���������
"
_user_specified_name
inputs/0:QM
'
_output_shapes
:���������
"
_user_specified_name
inputs/1
�
t
H__inference_subtract_16_layer_call_and_return_conditional_losses_1861167
inputs_0
inputs_1
identityW
subSubinputs_0inputs_1*
T0*'
_output_shapes
:���������2
sub[
IdentityIdentitysub:z:0*
T0*'
_output_shapes
:���������2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*9
_input_shapes(
&:���������:���������:Q M
'
_output_shapes
:���������
"
_user_specified_name
inputs/0:QM
'
_output_shapes
:���������
"
_user_specified_name
inputs/1
�:
�
H__inference_rank_net_16_layer_call_and_return_conditional_losses_1861095
inputs_0
inputs_19
'dense_48_matmul_readvariableop_resource:6
(dense_48_biasadd_readvariableop_resource:9
'dense_49_matmul_readvariableop_resource:6
(dense_49_biasadd_readvariableop_resource:9
'dense_50_matmul_readvariableop_resource:6
(dense_50_biasadd_readvariableop_resource:
identity��dense_48/BiasAdd/ReadVariableOp�!dense_48/BiasAdd_1/ReadVariableOp�dense_48/MatMul/ReadVariableOp� dense_48/MatMul_1/ReadVariableOp�dense_49/BiasAdd/ReadVariableOp�!dense_49/BiasAdd_1/ReadVariableOp�dense_49/MatMul/ReadVariableOp� dense_49/MatMul_1/ReadVariableOp�dense_50/BiasAdd/ReadVariableOp�!dense_50/BiasAdd_1/ReadVariableOp�dense_50/MatMul/ReadVariableOp� dense_50/MatMul_1/ReadVariableOp�
dense_48/MatMul/ReadVariableOpReadVariableOp'dense_48_matmul_readvariableop_resource*
_output_shapes

:*
dtype02 
dense_48/MatMul/ReadVariableOp�
dense_48/MatMulMatMulinputs_0&dense_48/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
dense_48/MatMul�
dense_48/BiasAdd/ReadVariableOpReadVariableOp(dense_48_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02!
dense_48/BiasAdd/ReadVariableOp�
dense_48/BiasAddBiasAdddense_48/MatMul:product:0'dense_48/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
dense_48/BiasAddy
dense_48/LeakyRelu	LeakyReludense_48/BiasAdd:output:0*'
_output_shapes
:���������2
dense_48/LeakyRelu�
 dense_48/MatMul_1/ReadVariableOpReadVariableOp'dense_48_matmul_readvariableop_resource*
_output_shapes

:*
dtype02"
 dense_48/MatMul_1/ReadVariableOp�
dense_48/MatMul_1MatMulinputs_1(dense_48/MatMul_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
dense_48/MatMul_1�
!dense_48/BiasAdd_1/ReadVariableOpReadVariableOp(dense_48_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02#
!dense_48/BiasAdd_1/ReadVariableOp�
dense_48/BiasAdd_1BiasAdddense_48/MatMul_1:product:0)dense_48/BiasAdd_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
dense_48/BiasAdd_1
dense_48/LeakyRelu_1	LeakyReludense_48/BiasAdd_1:output:0*'
_output_shapes
:���������2
dense_48/LeakyRelu_1�
dense_49/MatMul/ReadVariableOpReadVariableOp'dense_49_matmul_readvariableop_resource*
_output_shapes

:*
dtype02 
dense_49/MatMul/ReadVariableOp�
dense_49/MatMulMatMul dense_48/LeakyRelu:activations:0&dense_49/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
dense_49/MatMul�
dense_49/BiasAdd/ReadVariableOpReadVariableOp(dense_49_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02!
dense_49/BiasAdd/ReadVariableOp�
dense_49/BiasAddBiasAdddense_49/MatMul:product:0'dense_49/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
dense_49/BiasAddy
dense_49/LeakyRelu	LeakyReludense_49/BiasAdd:output:0*'
_output_shapes
:���������2
dense_49/LeakyRelu�
 dense_49/MatMul_1/ReadVariableOpReadVariableOp'dense_49_matmul_readvariableop_resource*
_output_shapes

:*
dtype02"
 dense_49/MatMul_1/ReadVariableOp�
dense_49/MatMul_1MatMul"dense_48/LeakyRelu_1:activations:0(dense_49/MatMul_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
dense_49/MatMul_1�
!dense_49/BiasAdd_1/ReadVariableOpReadVariableOp(dense_49_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02#
!dense_49/BiasAdd_1/ReadVariableOp�
dense_49/BiasAdd_1BiasAdddense_49/MatMul_1:product:0)dense_49/BiasAdd_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
dense_49/BiasAdd_1
dense_49/LeakyRelu_1	LeakyReludense_49/BiasAdd_1:output:0*'
_output_shapes
:���������2
dense_49/LeakyRelu_1�
dense_50/MatMul/ReadVariableOpReadVariableOp'dense_50_matmul_readvariableop_resource*
_output_shapes

:*
dtype02 
dense_50/MatMul/ReadVariableOp�
dense_50/MatMulMatMul dense_49/LeakyRelu:activations:0&dense_50/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
dense_50/MatMul�
dense_50/BiasAdd/ReadVariableOpReadVariableOp(dense_50_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02!
dense_50/BiasAdd/ReadVariableOp�
dense_50/BiasAddBiasAdddense_50/MatMul:product:0'dense_50/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
dense_50/BiasAdd�
 dense_50/MatMul_1/ReadVariableOpReadVariableOp'dense_50_matmul_readvariableop_resource*
_output_shapes

:*
dtype02"
 dense_50/MatMul_1/ReadVariableOp�
dense_50/MatMul_1MatMul"dense_49/LeakyRelu_1:activations:0(dense_50/MatMul_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
dense_50/MatMul_1�
!dense_50/BiasAdd_1/ReadVariableOpReadVariableOp(dense_50_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02#
!dense_50/BiasAdd_1/ReadVariableOp�
dense_50/BiasAdd_1BiasAdddense_50/MatMul_1:product:0)dense_50/BiasAdd_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
dense_50/BiasAdd_1�
subtract_16/subSubdense_50/BiasAdd:output:0dense_50/BiasAdd_1:output:0*
T0*'
_output_shapes
:���������2
subtract_16/subz
activation/SigmoidSigmoidsubtract_16/sub:z:0*
T0*'
_output_shapes
:���������2
activation/Sigmoidq
IdentityIdentityactivation/Sigmoid:y:0^NoOp*
T0*'
_output_shapes
:���������2

Identity�
NoOpNoOp ^dense_48/BiasAdd/ReadVariableOp"^dense_48/BiasAdd_1/ReadVariableOp^dense_48/MatMul/ReadVariableOp!^dense_48/MatMul_1/ReadVariableOp ^dense_49/BiasAdd/ReadVariableOp"^dense_49/BiasAdd_1/ReadVariableOp^dense_49/MatMul/ReadVariableOp!^dense_49/MatMul_1/ReadVariableOp ^dense_50/BiasAdd/ReadVariableOp"^dense_50/BiasAdd_1/ReadVariableOp^dense_50/MatMul/ReadVariableOp!^dense_50/MatMul_1/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*E
_input_shapes4
2:���������:���������: : : : : : 2B
dense_48/BiasAdd/ReadVariableOpdense_48/BiasAdd/ReadVariableOp2F
!dense_48/BiasAdd_1/ReadVariableOp!dense_48/BiasAdd_1/ReadVariableOp2@
dense_48/MatMul/ReadVariableOpdense_48/MatMul/ReadVariableOp2D
 dense_48/MatMul_1/ReadVariableOp dense_48/MatMul_1/ReadVariableOp2B
dense_49/BiasAdd/ReadVariableOpdense_49/BiasAdd/ReadVariableOp2F
!dense_49/BiasAdd_1/ReadVariableOp!dense_49/BiasAdd_1/ReadVariableOp2@
dense_49/MatMul/ReadVariableOpdense_49/MatMul/ReadVariableOp2D
 dense_49/MatMul_1/ReadVariableOp dense_49/MatMul_1/ReadVariableOp2B
dense_50/BiasAdd/ReadVariableOpdense_50/BiasAdd/ReadVariableOp2F
!dense_50/BiasAdd_1/ReadVariableOp!dense_50/BiasAdd_1/ReadVariableOp2@
dense_50/MatMul/ReadVariableOpdense_50/MatMul/ReadVariableOp2D
 dense_50/MatMul_1/ReadVariableOp dense_50/MatMul_1/ReadVariableOp:Q M
'
_output_shapes
:���������
"
_user_specified_name
inputs/0:QM
'
_output_shapes
:���������
"
_user_specified_name
inputs/1
�>
�
#__inference__traced_restore_1861325
file_prefix>
,assignvariableop_rank_net_16_dense_50_kernel::
,assignvariableop_1_rank_net_16_dense_50_bias:%
assignvariableop_2_sgd_iter:	 &
assignvariableop_3_sgd_decay: .
$assignvariableop_4_sgd_learning_rate: )
assignvariableop_5_sgd_momentum: @
.assignvariableop_6_rank_net_16_dense_48_kernel::
,assignvariableop_7_rank_net_16_dense_48_bias:@
.assignvariableop_8_rank_net_16_dense_49_kernel::
,assignvariableop_9_rank_net_16_dense_49_bias:#
assignvariableop_10_total: #
assignvariableop_11_count: %
assignvariableop_12_total_1: %
assignvariableop_13_count_1: 
identity_15��AssignVariableOp�AssignVariableOp_1�AssignVariableOp_10�AssignVariableOp_11�AssignVariableOp_12�AssignVariableOp_13�AssignVariableOp_2�AssignVariableOp_3�AssignVariableOp_4�AssignVariableOp_5�AssignVariableOp_6�AssignVariableOp_7�AssignVariableOp_8�AssignVariableOp_9�
RestoreV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*�
value�B�B#o/kernel/.ATTRIBUTES/VARIABLE_VALUEB!o/bias/.ATTRIBUTES/VARIABLE_VALUEB)optimizer/iter/.ATTRIBUTES/VARIABLE_VALUEB*optimizer/decay/.ATTRIBUTES/VARIABLE_VALUEB2optimizer/learning_rate/.ATTRIBUTES/VARIABLE_VALUEB-optimizer/momentum/.ATTRIBUTES/VARIABLE_VALUEB0trainable_variables/0/.ATTRIBUTES/VARIABLE_VALUEB0trainable_variables/1/.ATTRIBUTES/VARIABLE_VALUEB0trainable_variables/2/.ATTRIBUTES/VARIABLE_VALUEB0trainable_variables/3/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/count/.ATTRIBUTES/VARIABLE_VALUEB_CHECKPOINTABLE_OBJECT_GRAPH2
RestoreV2/tensor_names�
RestoreV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*1
value(B&B B B B B B B B B B B B B B B 2
RestoreV2/shape_and_slices�
	RestoreV2	RestoreV2file_prefixRestoreV2/tensor_names:output:0#RestoreV2/shape_and_slices:output:0"/device:CPU:0*P
_output_shapes>
<:::::::::::::::*
dtypes
2	2
	RestoreV2g
IdentityIdentityRestoreV2:tensors:0"/device:CPU:0*
T0*
_output_shapes
:2

Identity�
AssignVariableOpAssignVariableOp,assignvariableop_rank_net_16_dense_50_kernelIdentity:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOpk

Identity_1IdentityRestoreV2:tensors:1"/device:CPU:0*
T0*
_output_shapes
:2

Identity_1�
AssignVariableOp_1AssignVariableOp,assignvariableop_1_rank_net_16_dense_50_biasIdentity_1:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_1k

Identity_2IdentityRestoreV2:tensors:2"/device:CPU:0*
T0	*
_output_shapes
:2

Identity_2�
AssignVariableOp_2AssignVariableOpassignvariableop_2_sgd_iterIdentity_2:output:0"/device:CPU:0*
_output_shapes
 *
dtype0	2
AssignVariableOp_2k

Identity_3IdentityRestoreV2:tensors:3"/device:CPU:0*
T0*
_output_shapes
:2

Identity_3�
AssignVariableOp_3AssignVariableOpassignvariableop_3_sgd_decayIdentity_3:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_3k

Identity_4IdentityRestoreV2:tensors:4"/device:CPU:0*
T0*
_output_shapes
:2

Identity_4�
AssignVariableOp_4AssignVariableOp$assignvariableop_4_sgd_learning_rateIdentity_4:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_4k

Identity_5IdentityRestoreV2:tensors:5"/device:CPU:0*
T0*
_output_shapes
:2

Identity_5�
AssignVariableOp_5AssignVariableOpassignvariableop_5_sgd_momentumIdentity_5:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_5k

Identity_6IdentityRestoreV2:tensors:6"/device:CPU:0*
T0*
_output_shapes
:2

Identity_6�
AssignVariableOp_6AssignVariableOp.assignvariableop_6_rank_net_16_dense_48_kernelIdentity_6:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_6k

Identity_7IdentityRestoreV2:tensors:7"/device:CPU:0*
T0*
_output_shapes
:2

Identity_7�
AssignVariableOp_7AssignVariableOp,assignvariableop_7_rank_net_16_dense_48_biasIdentity_7:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_7k

Identity_8IdentityRestoreV2:tensors:8"/device:CPU:0*
T0*
_output_shapes
:2

Identity_8�
AssignVariableOp_8AssignVariableOp.assignvariableop_8_rank_net_16_dense_49_kernelIdentity_8:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_8k

Identity_9IdentityRestoreV2:tensors:9"/device:CPU:0*
T0*
_output_shapes
:2

Identity_9�
AssignVariableOp_9AssignVariableOp,assignvariableop_9_rank_net_16_dense_49_biasIdentity_9:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_9n
Identity_10IdentityRestoreV2:tensors:10"/device:CPU:0*
T0*
_output_shapes
:2
Identity_10�
AssignVariableOp_10AssignVariableOpassignvariableop_10_totalIdentity_10:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_10n
Identity_11IdentityRestoreV2:tensors:11"/device:CPU:0*
T0*
_output_shapes
:2
Identity_11�
AssignVariableOp_11AssignVariableOpassignvariableop_11_countIdentity_11:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_11n
Identity_12IdentityRestoreV2:tensors:12"/device:CPU:0*
T0*
_output_shapes
:2
Identity_12�
AssignVariableOp_12AssignVariableOpassignvariableop_12_total_1Identity_12:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_12n
Identity_13IdentityRestoreV2:tensors:13"/device:CPU:0*
T0*
_output_shapes
:2
Identity_13�
AssignVariableOp_13AssignVariableOpassignvariableop_13_count_1Identity_13:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_139
NoOpNoOp"/device:CPU:0*
_output_shapes
 2
NoOp�
Identity_14Identityfile_prefix^AssignVariableOp^AssignVariableOp_1^AssignVariableOp_10^AssignVariableOp_11^AssignVariableOp_12^AssignVariableOp_13^AssignVariableOp_2^AssignVariableOp_3^AssignVariableOp_4^AssignVariableOp_5^AssignVariableOp_6^AssignVariableOp_7^AssignVariableOp_8^AssignVariableOp_9^NoOp"/device:CPU:0*
T0*
_output_shapes
: 2
Identity_14f
Identity_15IdentityIdentity_14:output:0^NoOp_1*
T0*
_output_shapes
: 2
Identity_15�
NoOp_1NoOp^AssignVariableOp^AssignVariableOp_1^AssignVariableOp_10^AssignVariableOp_11^AssignVariableOp_12^AssignVariableOp_13^AssignVariableOp_2^AssignVariableOp_3^AssignVariableOp_4^AssignVariableOp_5^AssignVariableOp_6^AssignVariableOp_7^AssignVariableOp_8^AssignVariableOp_9*"
_acd_function_control_output(*
_output_shapes
 2
NoOp_1"#
identity_15Identity_15:output:0*1
_input_shapes 
: : : : : : : : : : : : : : : 2$
AssignVariableOpAssignVariableOp2(
AssignVariableOp_1AssignVariableOp_12*
AssignVariableOp_10AssignVariableOp_102*
AssignVariableOp_11AssignVariableOp_112*
AssignVariableOp_12AssignVariableOp_122*
AssignVariableOp_13AssignVariableOp_132(
AssignVariableOp_2AssignVariableOp_22(
AssignVariableOp_3AssignVariableOp_32(
AssignVariableOp_4AssignVariableOp_42(
AssignVariableOp_5AssignVariableOp_52(
AssignVariableOp_6AssignVariableOp_62(
AssignVariableOp_7AssignVariableOp_72(
AssignVariableOp_8AssignVariableOp_82(
AssignVariableOp_9AssignVariableOp_9:C ?

_output_shapes
: 
%
_user_specified_namefile_prefix
�:
�
H__inference_rank_net_16_layer_call_and_return_conditional_losses_1861136
input_1
input_29
'dense_48_matmul_readvariableop_resource:6
(dense_48_biasadd_readvariableop_resource:9
'dense_49_matmul_readvariableop_resource:6
(dense_49_biasadd_readvariableop_resource:9
'dense_50_matmul_readvariableop_resource:6
(dense_50_biasadd_readvariableop_resource:
identity��dense_48/BiasAdd/ReadVariableOp�!dense_48/BiasAdd_1/ReadVariableOp�dense_48/MatMul/ReadVariableOp� dense_48/MatMul_1/ReadVariableOp�dense_49/BiasAdd/ReadVariableOp�!dense_49/BiasAdd_1/ReadVariableOp�dense_49/MatMul/ReadVariableOp� dense_49/MatMul_1/ReadVariableOp�dense_50/BiasAdd/ReadVariableOp�!dense_50/BiasAdd_1/ReadVariableOp�dense_50/MatMul/ReadVariableOp� dense_50/MatMul_1/ReadVariableOp�
dense_48/MatMul/ReadVariableOpReadVariableOp'dense_48_matmul_readvariableop_resource*
_output_shapes

:*
dtype02 
dense_48/MatMul/ReadVariableOp�
dense_48/MatMulMatMulinput_1&dense_48/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
dense_48/MatMul�
dense_48/BiasAdd/ReadVariableOpReadVariableOp(dense_48_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02!
dense_48/BiasAdd/ReadVariableOp�
dense_48/BiasAddBiasAdddense_48/MatMul:product:0'dense_48/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
dense_48/BiasAddy
dense_48/LeakyRelu	LeakyReludense_48/BiasAdd:output:0*'
_output_shapes
:���������2
dense_48/LeakyRelu�
 dense_48/MatMul_1/ReadVariableOpReadVariableOp'dense_48_matmul_readvariableop_resource*
_output_shapes

:*
dtype02"
 dense_48/MatMul_1/ReadVariableOp�
dense_48/MatMul_1MatMulinput_2(dense_48/MatMul_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
dense_48/MatMul_1�
!dense_48/BiasAdd_1/ReadVariableOpReadVariableOp(dense_48_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02#
!dense_48/BiasAdd_1/ReadVariableOp�
dense_48/BiasAdd_1BiasAdddense_48/MatMul_1:product:0)dense_48/BiasAdd_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
dense_48/BiasAdd_1
dense_48/LeakyRelu_1	LeakyReludense_48/BiasAdd_1:output:0*'
_output_shapes
:���������2
dense_48/LeakyRelu_1�
dense_49/MatMul/ReadVariableOpReadVariableOp'dense_49_matmul_readvariableop_resource*
_output_shapes

:*
dtype02 
dense_49/MatMul/ReadVariableOp�
dense_49/MatMulMatMul dense_48/LeakyRelu:activations:0&dense_49/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
dense_49/MatMul�
dense_49/BiasAdd/ReadVariableOpReadVariableOp(dense_49_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02!
dense_49/BiasAdd/ReadVariableOp�
dense_49/BiasAddBiasAdddense_49/MatMul:product:0'dense_49/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
dense_49/BiasAddy
dense_49/LeakyRelu	LeakyReludense_49/BiasAdd:output:0*'
_output_shapes
:���������2
dense_49/LeakyRelu�
 dense_49/MatMul_1/ReadVariableOpReadVariableOp'dense_49_matmul_readvariableop_resource*
_output_shapes

:*
dtype02"
 dense_49/MatMul_1/ReadVariableOp�
dense_49/MatMul_1MatMul"dense_48/LeakyRelu_1:activations:0(dense_49/MatMul_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
dense_49/MatMul_1�
!dense_49/BiasAdd_1/ReadVariableOpReadVariableOp(dense_49_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02#
!dense_49/BiasAdd_1/ReadVariableOp�
dense_49/BiasAdd_1BiasAdddense_49/MatMul_1:product:0)dense_49/BiasAdd_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
dense_49/BiasAdd_1
dense_49/LeakyRelu_1	LeakyReludense_49/BiasAdd_1:output:0*'
_output_shapes
:���������2
dense_49/LeakyRelu_1�
dense_50/MatMul/ReadVariableOpReadVariableOp'dense_50_matmul_readvariableop_resource*
_output_shapes

:*
dtype02 
dense_50/MatMul/ReadVariableOp�
dense_50/MatMulMatMul dense_49/LeakyRelu:activations:0&dense_50/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
dense_50/MatMul�
dense_50/BiasAdd/ReadVariableOpReadVariableOp(dense_50_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02!
dense_50/BiasAdd/ReadVariableOp�
dense_50/BiasAddBiasAdddense_50/MatMul:product:0'dense_50/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
dense_50/BiasAdd�
 dense_50/MatMul_1/ReadVariableOpReadVariableOp'dense_50_matmul_readvariableop_resource*
_output_shapes

:*
dtype02"
 dense_50/MatMul_1/ReadVariableOp�
dense_50/MatMul_1MatMul"dense_49/LeakyRelu_1:activations:0(dense_50/MatMul_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
dense_50/MatMul_1�
!dense_50/BiasAdd_1/ReadVariableOpReadVariableOp(dense_50_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02#
!dense_50/BiasAdd_1/ReadVariableOp�
dense_50/BiasAdd_1BiasAdddense_50/MatMul_1:product:0)dense_50/BiasAdd_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
dense_50/BiasAdd_1�
subtract_16/subSubdense_50/BiasAdd:output:0dense_50/BiasAdd_1:output:0*
T0*'
_output_shapes
:���������2
subtract_16/subz
activation/SigmoidSigmoidsubtract_16/sub:z:0*
T0*'
_output_shapes
:���������2
activation/Sigmoidq
IdentityIdentityactivation/Sigmoid:y:0^NoOp*
T0*'
_output_shapes
:���������2

Identity�
NoOpNoOp ^dense_48/BiasAdd/ReadVariableOp"^dense_48/BiasAdd_1/ReadVariableOp^dense_48/MatMul/ReadVariableOp!^dense_48/MatMul_1/ReadVariableOp ^dense_49/BiasAdd/ReadVariableOp"^dense_49/BiasAdd_1/ReadVariableOp^dense_49/MatMul/ReadVariableOp!^dense_49/MatMul_1/ReadVariableOp ^dense_50/BiasAdd/ReadVariableOp"^dense_50/BiasAdd_1/ReadVariableOp^dense_50/MatMul/ReadVariableOp!^dense_50/MatMul_1/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*E
_input_shapes4
2:���������:���������: : : : : : 2B
dense_48/BiasAdd/ReadVariableOpdense_48/BiasAdd/ReadVariableOp2F
!dense_48/BiasAdd_1/ReadVariableOp!dense_48/BiasAdd_1/ReadVariableOp2@
dense_48/MatMul/ReadVariableOpdense_48/MatMul/ReadVariableOp2D
 dense_48/MatMul_1/ReadVariableOp dense_48/MatMul_1/ReadVariableOp2B
dense_49/BiasAdd/ReadVariableOpdense_49/BiasAdd/ReadVariableOp2F
!dense_49/BiasAdd_1/ReadVariableOp!dense_49/BiasAdd_1/ReadVariableOp2@
dense_49/MatMul/ReadVariableOpdense_49/MatMul/ReadVariableOp2D
 dense_49/MatMul_1/ReadVariableOp dense_49/MatMul_1/ReadVariableOp2B
dense_50/BiasAdd/ReadVariableOpdense_50/BiasAdd/ReadVariableOp2F
!dense_50/BiasAdd_1/ReadVariableOp!dense_50/BiasAdd_1/ReadVariableOp2@
dense_50/MatMul/ReadVariableOpdense_50/MatMul/ReadVariableOp2D
 dense_50/MatMul_1/ReadVariableOp dense_50/MatMul_1/ReadVariableOp:P L
'
_output_shapes
:���������
!
_user_specified_name	input_1:PL
'
_output_shapes
:���������
!
_user_specified_name	input_2
�
�
*__inference_dense_50_layer_call_fn_1861145

inputs
unknown:
	unknown_0:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_dense_50_layer_call_and_return_conditional_losses_18608742
StatefulPartitionedCall{
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:���������2

Identityh
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:���������: : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs
�'
�
 __inference__traced_save_1861273
file_prefix:
6savev2_rank_net_16_dense_50_kernel_read_readvariableop8
4savev2_rank_net_16_dense_50_bias_read_readvariableop'
#savev2_sgd_iter_read_readvariableop	(
$savev2_sgd_decay_read_readvariableop0
,savev2_sgd_learning_rate_read_readvariableop+
'savev2_sgd_momentum_read_readvariableop:
6savev2_rank_net_16_dense_48_kernel_read_readvariableop8
4savev2_rank_net_16_dense_48_bias_read_readvariableop:
6savev2_rank_net_16_dense_49_kernel_read_readvariableop8
4savev2_rank_net_16_dense_49_bias_read_readvariableop$
 savev2_total_read_readvariableop$
 savev2_count_read_readvariableop&
"savev2_total_1_read_readvariableop&
"savev2_count_1_read_readvariableop
savev2_const

identity_1��MergeV2Checkpoints�
StaticRegexFullMatchStaticRegexFullMatchfile_prefix"/device:CPU:**
_output_shapes
: *
pattern
^s3://.*2
StaticRegexFullMatchc
ConstConst"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B.part2
Constl
Const_1Const"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B
_temp/part2	
Const_1�
SelectSelectStaticRegexFullMatch:output:0Const:output:0Const_1:output:0"/device:CPU:**
T0*
_output_shapes
: 2
Selectt

StringJoin
StringJoinfile_prefixSelect:output:0"/device:CPU:**
N*
_output_shapes
: 2

StringJoinZ

num_shardsConst*
_output_shapes
: *
dtype0*
value	B :2

num_shards
ShardedFilename/shardConst"/device:CPU:0*
_output_shapes
: *
dtype0*
value	B : 2
ShardedFilename/shard�
ShardedFilenameShardedFilenameStringJoin:output:0ShardedFilename/shard:output:0num_shards:output:0"/device:CPU:0*
_output_shapes
: 2
ShardedFilename�
SaveV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*�
value�B�B#o/kernel/.ATTRIBUTES/VARIABLE_VALUEB!o/bias/.ATTRIBUTES/VARIABLE_VALUEB)optimizer/iter/.ATTRIBUTES/VARIABLE_VALUEB*optimizer/decay/.ATTRIBUTES/VARIABLE_VALUEB2optimizer/learning_rate/.ATTRIBUTES/VARIABLE_VALUEB-optimizer/momentum/.ATTRIBUTES/VARIABLE_VALUEB0trainable_variables/0/.ATTRIBUTES/VARIABLE_VALUEB0trainable_variables/1/.ATTRIBUTES/VARIABLE_VALUEB0trainable_variables/2/.ATTRIBUTES/VARIABLE_VALUEB0trainable_variables/3/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/count/.ATTRIBUTES/VARIABLE_VALUEB_CHECKPOINTABLE_OBJECT_GRAPH2
SaveV2/tensor_names�
SaveV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*1
value(B&B B B B B B B B B B B B B B B 2
SaveV2/shape_and_slices�
SaveV2SaveV2ShardedFilename:filename:0SaveV2/tensor_names:output:0 SaveV2/shape_and_slices:output:06savev2_rank_net_16_dense_50_kernel_read_readvariableop4savev2_rank_net_16_dense_50_bias_read_readvariableop#savev2_sgd_iter_read_readvariableop$savev2_sgd_decay_read_readvariableop,savev2_sgd_learning_rate_read_readvariableop'savev2_sgd_momentum_read_readvariableop6savev2_rank_net_16_dense_48_kernel_read_readvariableop4savev2_rank_net_16_dense_48_bias_read_readvariableop6savev2_rank_net_16_dense_49_kernel_read_readvariableop4savev2_rank_net_16_dense_49_bias_read_readvariableop savev2_total_read_readvariableop savev2_count_read_readvariableop"savev2_total_1_read_readvariableop"savev2_count_1_read_readvariableopsavev2_const"/device:CPU:0*
_output_shapes
 *
dtypes
2	2
SaveV2�
&MergeV2Checkpoints/checkpoint_prefixesPackShardedFilename:filename:0^SaveV2"/device:CPU:0*
N*
T0*
_output_shapes
:2(
&MergeV2Checkpoints/checkpoint_prefixes�
MergeV2CheckpointsMergeV2Checkpoints/MergeV2Checkpoints/checkpoint_prefixes:output:0file_prefix"/device:CPU:0*
_output_shapes
 2
MergeV2Checkpointsr
IdentityIdentityfile_prefix^MergeV2Checkpoints"/device:CPU:0*
T0*
_output_shapes
: 2

Identity_

Identity_1IdentityIdentity:output:0^NoOp*
T0*
_output_shapes
: 2

Identity_1c
NoOpNoOp^MergeV2Checkpoints*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"!

identity_1Identity_1:output:0*W
_input_shapesF
D: ::: : : : ::::: : : : : 2(
MergeV2CheckpointsMergeV2Checkpoints:C ?

_output_shapes
: 
%
_user_specified_namefile_prefix:$ 

_output_shapes

:: 

_output_shapes
::

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :$ 

_output_shapes

:: 

_output_shapes
::$	 

_output_shapes

:: 


_output_shapes
::

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: 
�
Y
-__inference_subtract_16_layer_call_fn_1861161
inputs_0
inputs_1
identity�
PartitionedCallPartitionedCallinputs_0inputs_1*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_subtract_16_layer_call_and_return_conditional_losses_18608892
PartitionedCalll
IdentityIdentityPartitionedCall:output:0*
T0*'
_output_shapes
:���������2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*9
_input_shapes(
&:���������:���������:Q M
'
_output_shapes
:���������
"
_user_specified_name
inputs/0:QM
'
_output_shapes
:���������
"
_user_specified_name
inputs/1
�
�
E__inference_dense_48_layer_call_and_return_conditional_losses_1861187

inputs0
matmul_readvariableop_resource:-
biasadd_readvariableop_resource:
identity��BiasAdd/ReadVariableOp�MatMul/ReadVariableOp�
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:*
dtype02
MatMul/ReadVariableOps
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
MatMul�
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype02
BiasAdd/ReadVariableOp�
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2	
BiasAdd^
	LeakyRelu	LeakyReluBiasAdd:output:0*'
_output_shapes
:���������2
	LeakyRelur
IdentityIdentityLeakyRelu:activations:0^NoOp*
T0*'
_output_shapes
:���������2

Identity
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:���������: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
E__inference_dense_48_layer_call_and_return_conditional_losses_1860835

inputs0
matmul_readvariableop_resource:-
biasadd_readvariableop_resource:
identity��BiasAdd/ReadVariableOp�MatMul/ReadVariableOp�
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:*
dtype02
MatMul/ReadVariableOps
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2
MatMul�
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype02
BiasAdd/ReadVariableOp�
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2	
BiasAdd^
	LeakyRelu	LeakyReluBiasAdd:output:0*'
_output_shapes
:���������2
	LeakyRelur
IdentityIdentityLeakyRelu:activations:0^NoOp*
T0*'
_output_shapes
:���������2

Identity
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:���������: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs
�&
�
H__inference_rank_net_16_layer_call_and_return_conditional_losses_1860893

inputs
inputs_1"
dense_48_1860836:
dense_48_1860838:"
dense_49_1860856:
dense_49_1860858:"
dense_50_1860875:
dense_50_1860877:
identity�� dense_48/StatefulPartitionedCall�"dense_48/StatefulPartitionedCall_1� dense_49/StatefulPartitionedCall�"dense_49/StatefulPartitionedCall_1� dense_50/StatefulPartitionedCall�"dense_50/StatefulPartitionedCall_1�
 dense_48/StatefulPartitionedCallStatefulPartitionedCallinputsdense_48_1860836dense_48_1860838*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_dense_48_layer_call_and_return_conditional_losses_18608352"
 dense_48/StatefulPartitionedCall�
"dense_48/StatefulPartitionedCall_1StatefulPartitionedCallinputs_1dense_48_1860836dense_48_1860838*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_dense_48_layer_call_and_return_conditional_losses_18608352$
"dense_48/StatefulPartitionedCall_1�
 dense_49/StatefulPartitionedCallStatefulPartitionedCall)dense_48/StatefulPartitionedCall:output:0dense_49_1860856dense_49_1860858*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_dense_49_layer_call_and_return_conditional_losses_18608552"
 dense_49/StatefulPartitionedCall�
"dense_49/StatefulPartitionedCall_1StatefulPartitionedCall+dense_48/StatefulPartitionedCall_1:output:0dense_49_1860856dense_49_1860858*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_dense_49_layer_call_and_return_conditional_losses_18608552$
"dense_49/StatefulPartitionedCall_1�
 dense_50/StatefulPartitionedCallStatefulPartitionedCall)dense_49/StatefulPartitionedCall:output:0dense_50_1860875dense_50_1860877*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_dense_50_layer_call_and_return_conditional_losses_18608742"
 dense_50/StatefulPartitionedCall�
"dense_50/StatefulPartitionedCall_1StatefulPartitionedCall+dense_49/StatefulPartitionedCall_1:output:0dense_50_1860875dense_50_1860877*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_dense_50_layer_call_and_return_conditional_losses_18608742$
"dense_50/StatefulPartitionedCall_1�
subtract_16/PartitionedCallPartitionedCall)dense_50/StatefulPartitionedCall:output:0+dense_50/StatefulPartitionedCall_1:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_subtract_16_layer_call_and_return_conditional_losses_18608892
subtract_16/PartitionedCall�
activation/SigmoidSigmoid$subtract_16/PartitionedCall:output:0*
T0*'
_output_shapes
:���������2
activation/Sigmoidq
IdentityIdentityactivation/Sigmoid:y:0^NoOp*
T0*'
_output_shapes
:���������2

Identity�
NoOpNoOp!^dense_48/StatefulPartitionedCall#^dense_48/StatefulPartitionedCall_1!^dense_49/StatefulPartitionedCall#^dense_49/StatefulPartitionedCall_1!^dense_50/StatefulPartitionedCall#^dense_50/StatefulPartitionedCall_1*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*E
_input_shapes4
2:���������:���������: : : : : : 2D
 dense_48/StatefulPartitionedCall dense_48/StatefulPartitionedCall2H
"dense_48/StatefulPartitionedCall_1"dense_48/StatefulPartitionedCall_12D
 dense_49/StatefulPartitionedCall dense_49/StatefulPartitionedCall2H
"dense_49/StatefulPartitionedCall_1"dense_49/StatefulPartitionedCall_12D
 dense_50/StatefulPartitionedCall dense_50/StatefulPartitionedCall2H
"dense_50/StatefulPartitionedCall_1"dense_50/StatefulPartitionedCall_1:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs:OK
'
_output_shapes
:���������
 
_user_specified_nameinputs"�L
saver_filename:0StatefulPartitionedCall_1:0StatefulPartitionedCall_28"
saved_model_main_op

NoOp*>
__saved_model_init_op%#
__saved_model_init_op

NoOp*�
serving_default�
;
input_10
serving_default_input_1:0���������
;
input_20
serving_default_input_2:0���������<
output_10
StatefulPartitionedCall:0���������tensorflow/serving/predict:�Q
�
	dense
o
oi_minus_oj
	optimizer
trainable_variables
regularization_losses
	variables
	keras_api
	
signatures
J__call__
K_default_save_signature
*L&call_and_return_all_conditional_losses"
_tf_keras_model
.

0
1"
trackable_list_wrapper
�

kernel
bias
trainable_variables
regularization_losses
	variables
	keras_api
M__call__
*N&call_and_return_all_conditional_losses"
_tf_keras_layer
�
trainable_variables
regularization_losses
	variables
	keras_api
O__call__
*P&call_and_return_all_conditional_losses"
_tf_keras_layer
I
iter
	decay
learning_rate
momentum"
	optimizer
J
0
1
2
3
4
5"
trackable_list_wrapper
 "
trackable_list_wrapper
J
0
1
2
3
4
5"
trackable_list_wrapper
�
non_trainable_variables
metrics
trainable_variables
 layer_regularization_losses
!layer_metrics

"layers
regularization_losses
	variables
J__call__
K_default_save_signature
*L&call_and_return_all_conditional_losses
&L"call_and_return_conditional_losses"
_generic_user_object
,
Qserving_default"
signature_map
�

kernel
bias
#trainable_variables
$regularization_losses
%	variables
&	keras_api
R__call__
*S&call_and_return_all_conditional_losses"
_tf_keras_layer
�

kernel
bias
'trainable_variables
(regularization_losses
)	variables
*	keras_api
T__call__
*U&call_and_return_all_conditional_losses"
_tf_keras_layer
-:+2rank_net_16/dense_50/kernel
':%2rank_net_16/dense_50/bias
.
0
1"
trackable_list_wrapper
 "
trackable_list_wrapper
.
0
1"
trackable_list_wrapper
�
+non_trainable_variables
,metrics
trainable_variables
-layer_regularization_losses
.layer_metrics

/layers
regularization_losses
	variables
M__call__
*N&call_and_return_all_conditional_losses
&N"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
0non_trainable_variables
1metrics
trainable_variables
2layer_regularization_losses
3layer_metrics

4layers
regularization_losses
	variables
O__call__
*P&call_and_return_all_conditional_losses
&P"call_and_return_conditional_losses"
_generic_user_object
:	 (2SGD/iter
: (2	SGD/decay
: (2SGD/learning_rate
: (2SGD/momentum
-:+2rank_net_16/dense_48/kernel
':%2rank_net_16/dense_48/bias
-:+2rank_net_16/dense_49/kernel
':%2rank_net_16/dense_49/bias
 "
trackable_list_wrapper
.
50
61"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
<

0
1
2
3"
trackable_list_wrapper
.
0
1"
trackable_list_wrapper
 "
trackable_list_wrapper
.
0
1"
trackable_list_wrapper
�
7non_trainable_variables
8metrics
#trainable_variables
9layer_regularization_losses
:layer_metrics

;layers
$regularization_losses
%	variables
R__call__
*S&call_and_return_all_conditional_losses
&S"call_and_return_conditional_losses"
_generic_user_object
.
0
1"
trackable_list_wrapper
 "
trackable_list_wrapper
.
0
1"
trackable_list_wrapper
�
<non_trainable_variables
=metrics
'trainable_variables
>layer_regularization_losses
?layer_metrics

@layers
(regularization_losses
)	variables
T__call__
*U&call_and_return_all_conditional_losses
&U"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
N
	Atotal
	Bcount
C	variables
D	keras_api"
_tf_keras_metric
^
	Etotal
	Fcount
G
_fn_kwargs
H	variables
I	keras_api"
_tf_keras_metric
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
:  (2total
:  (2count
.
A0
B1"
trackable_list_wrapper
-
C	variables"
_generic_user_object
:  (2total
:  (2count
 "
trackable_dict_wrapper
.
E0
F1"
trackable_list_wrapper
-
H	variables"
_generic_user_object
�2�
-__inference_rank_net_16_layer_call_fn_1861036
-__inference_rank_net_16_layer_call_fn_1861054�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�B�
"__inference__wrapped_model_1860815input_1input_2"�
���
FullArgSpec
args� 
varargsjargs
varkwjkwargs
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
H__inference_rank_net_16_layer_call_and_return_conditional_losses_1861095
H__inference_rank_net_16_layer_call_and_return_conditional_losses_1861136�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
*__inference_dense_50_layer_call_fn_1861145�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
E__inference_dense_50_layer_call_and_return_conditional_losses_1861155�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
-__inference_subtract_16_layer_call_fn_1861161�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
H__inference_subtract_16_layer_call_and_return_conditional_losses_1861167�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�B�
%__inference_signature_wrapper_1861018input_1input_2"�
���
FullArgSpec
args� 
varargs
 
varkwjkwargs
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
*__inference_dense_48_layer_call_fn_1861176�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
E__inference_dense_48_layer_call_and_return_conditional_losses_1861187�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
*__inference_dense_49_layer_call_fn_1861196�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
E__inference_dense_49_layer_call_and_return_conditional_losses_1861207�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 �
"__inference__wrapped_model_1860815�X�U
N�K
I�F
!�
input_1���������
!�
input_2���������
� "3�0
.
output_1"�
output_1����������
E__inference_dense_48_layer_call_and_return_conditional_losses_1861187\/�,
%�"
 �
inputs���������
� "%�"
�
0���������
� }
*__inference_dense_48_layer_call_fn_1861176O/�,
%�"
 �
inputs���������
� "�����������
E__inference_dense_49_layer_call_and_return_conditional_losses_1861207\/�,
%�"
 �
inputs���������
� "%�"
�
0���������
� }
*__inference_dense_49_layer_call_fn_1861196O/�,
%�"
 �
inputs���������
� "�����������
E__inference_dense_50_layer_call_and_return_conditional_losses_1861155\/�,
%�"
 �
inputs���������
� "%�"
�
0���������
� }
*__inference_dense_50_layer_call_fn_1861145O/�,
%�"
 �
inputs���������
� "�����������
H__inference_rank_net_16_layer_call_and_return_conditional_losses_1861095�Z�W
P�M
K�H
"�
inputs/0���������
"�
inputs/1���������
� "%�"
�
0���������
� �
H__inference_rank_net_16_layer_call_and_return_conditional_losses_1861136�X�U
N�K
I�F
!�
input_1���������
!�
input_2���������
� "%�"
�
0���������
� �
-__inference_rank_net_16_layer_call_fn_1861036|X�U
N�K
I�F
!�
input_1���������
!�
input_2���������
� "�����������
-__inference_rank_net_16_layer_call_fn_1861054~Z�W
P�M
K�H
"�
inputs/0���������
"�
inputs/1���������
� "�����������
%__inference_signature_wrapper_1861018�i�f
� 
_�\
,
input_1!�
input_1���������
,
input_2!�
input_2���������"3�0
.
output_1"�
output_1����������
H__inference_subtract_16_layer_call_and_return_conditional_losses_1861167�Z�W
P�M
K�H
"�
inputs/0���������
"�
inputs/1���������
� "%�"
�
0���������
� �
-__inference_subtract_16_layer_call_fn_1861161vZ�W
P�M
K�H
"�
inputs/0���������
"�
inputs/1���������
� "����������