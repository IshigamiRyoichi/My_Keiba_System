йт
╣і
B
AssignVariableOp
resource
value"dtype"
dtypetypeѕ
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
alphafloat%═╠L>"
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
delete_old_dirsbool(ѕ
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
dtypetypeѕ
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0ѕ
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0ѕ
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
Й
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
executor_typestring ѕ
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
ќ
VarHandleOp
resource"
	containerstring "
shared_namestring "
dtypetype"
shapeshape"#
allowed_deviceslist(string)
 ѕ"serve*2.6.02v2.6.0-rc2-32-g919f693420e8ъѓ
њ
rank_net_20/dense_62/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:*,
shared_namerank_net_20/dense_62/kernel
І
/rank_net_20/dense_62/kernel/Read/ReadVariableOpReadVariableOprank_net_20/dense_62/kernel*
_output_shapes

:*
dtype0
і
rank_net_20/dense_62/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape:**
shared_namerank_net_20/dense_62/bias
Ѓ
-rank_net_20/dense_62/bias/Read/ReadVariableOpReadVariableOprank_net_20/dense_62/bias*
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
њ
rank_net_20/dense_60/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:*,
shared_namerank_net_20/dense_60/kernel
І
/rank_net_20/dense_60/kernel/Read/ReadVariableOpReadVariableOprank_net_20/dense_60/kernel*
_output_shapes

:*
dtype0
і
rank_net_20/dense_60/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape:**
shared_namerank_net_20/dense_60/bias
Ѓ
-rank_net_20/dense_60/bias/Read/ReadVariableOpReadVariableOprank_net_20/dense_60/bias*
_output_shapes
:*
dtype0
њ
rank_net_20/dense_61/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:*,
shared_namerank_net_20/dense_61/kernel
І
/rank_net_20/dense_61/kernel/Read/ReadVariableOpReadVariableOprank_net_20/dense_61/kernel*
_output_shapes

:*
dtype0
і
rank_net_20/dense_61/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape:**
shared_namerank_net_20/dense_61/bias
Ѓ
-rank_net_20/dense_61/bias/Read/ReadVariableOpReadVariableOprank_net_20/dense_61/bias*
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
о
ConstConst"/device:CPU:0*
_output_shapes
: *
dtype0*Љ
valueЄBё B§
ћ
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
Г
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
VARIABLE_VALUErank_net_20/dense_62/kernel#o/kernel/.ATTRIBUTES/VARIABLE_VALUE
PN
VARIABLE_VALUErank_net_20/dense_62/bias!o/bias/.ATTRIBUTES/VARIABLE_VALUE

0
1
 

0
1
Г
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
Г
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
VARIABLE_VALUErank_net_20/dense_60/kernel0trainable_variables/0/.ATTRIBUTES/VARIABLE_VALUE
_]
VARIABLE_VALUErank_net_20/dense_60/bias0trainable_variables/1/.ATTRIBUTES/VARIABLE_VALUE
a_
VARIABLE_VALUErank_net_20/dense_61/kernel0trainable_variables/2/.ATTRIBUTES/VARIABLE_VALUE
_]
VARIABLE_VALUErank_net_20/dense_61/bias0trainable_variables/3/.ATTRIBUTES/VARIABLE_VALUE
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
Г
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
Г
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
:         *
dtype0*
shape:         
z
serving_default_input_2Placeholder*'
_output_shapes
:         *
dtype0*
shape:         
Ђ
StatefulPartitionedCallStatefulPartitionedCallserving_default_input_1serving_default_input_2rank_net_20/dense_60/kernelrank_net_20/dense_60/biasrank_net_20/dense_61/kernelrank_net_20/dense_61/biasrank_net_20/dense_62/kernelrank_net_20/dense_62/bias*
Tin

2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         *(
_read_only_resource_inputs

*-
config_proto

CPU

GPU 2J 8ѓ *.
f)R'
%__inference_signature_wrapper_2218346
O
saver_filenamePlaceholder*
_output_shapes
: *
dtype0*
shape: 
└
StatefulPartitionedCall_1StatefulPartitionedCallsaver_filename/rank_net_20/dense_62/kernel/Read/ReadVariableOp-rank_net_20/dense_62/bias/Read/ReadVariableOpSGD/iter/Read/ReadVariableOpSGD/decay/Read/ReadVariableOp%SGD/learning_rate/Read/ReadVariableOp SGD/momentum/Read/ReadVariableOp/rank_net_20/dense_60/kernel/Read/ReadVariableOp-rank_net_20/dense_60/bias/Read/ReadVariableOp/rank_net_20/dense_61/kernel/Read/ReadVariableOp-rank_net_20/dense_61/bias/Read/ReadVariableOptotal/Read/ReadVariableOpcount/Read/ReadVariableOptotal_1/Read/ReadVariableOpcount_1/Read/ReadVariableOpConst*
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
GPU 2J 8ѓ *)
f$R"
 __inference__traced_save_2218542
Б
StatefulPartitionedCall_2StatefulPartitionedCallsaver_filenamerank_net_20/dense_62/kernelrank_net_20/dense_62/biasSGD/iter	SGD/decaySGD/learning_rateSGD/momentumrank_net_20/dense_60/kernelrank_net_20/dense_60/biasrank_net_20/dense_61/kernelrank_net_20/dense_61/biastotalcounttotal_1count_1*
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
GPU 2J 8ѓ *,
f'R%
#__inference__traced_restore_2218594ћй
Д

Ш
E__inference_dense_62_layer_call_and_return_conditional_losses_2218424

inputs0
matmul_readvariableop_resource:-
biasadd_readvariableop_resource:
identityѕбBiasAdd/ReadVariableOpбMatMul/ReadVariableOpЇ
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:*
dtype02
MatMul/ReadVariableOps
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
MatMulї
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype02
BiasAdd/ReadVariableOpЂ
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2	
BiasAddk
IdentityIdentityBiasAdd:output:0^NoOp*
T0*'
_output_shapes
:         2

Identity
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:         : : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:         
 
_user_specified_nameinputs
ј
Ш
E__inference_dense_60_layer_call_and_return_conditional_losses_2218456

inputs0
matmul_readvariableop_resource:-
biasadd_readvariableop_resource:
identityѕбBiasAdd/ReadVariableOpбMatMul/ReadVariableOpЇ
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:*
dtype02
MatMul/ReadVariableOps
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
MatMulї
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype02
BiasAdd/ReadVariableOpЂ
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2	
BiasAdd^
	LeakyRelu	LeakyReluBiasAdd:output:0*'
_output_shapes
:         2
	LeakyRelur
IdentityIdentityLeakyRelu:activations:0^NoOp*
T0*'
_output_shapes
:         2

Identity
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:         : : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:         
 
_user_specified_nameinputs
ј
Ш
E__inference_dense_60_layer_call_and_return_conditional_losses_2218163

inputs0
matmul_readvariableop_resource:-
biasadd_readvariableop_resource:
identityѕбBiasAdd/ReadVariableOpбMatMul/ReadVariableOpЇ
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:*
dtype02
MatMul/ReadVariableOps
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
MatMulї
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype02
BiasAdd/ReadVariableOpЂ
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2	
BiasAdd^
	LeakyRelu	LeakyReluBiasAdd:output:0*'
_output_shapes
:         2
	LeakyRelur
IdentityIdentityLeakyRelu:activations:0^NoOp*
T0*'
_output_shapes
:         2

Identity
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:         : : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:         
 
_user_specified_nameinputs
з
Ќ
*__inference_dense_62_layer_call_fn_2218414

inputs
unknown:
	unknown_0:
identityѕбStatefulPartitionedCallш
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         *$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8ѓ *N
fIRG
E__inference_dense_62_layer_call_and_return_conditional_losses_22182022
StatefulPartitionedCall{
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:         2

Identityh
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:         : : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:         
 
_user_specified_nameinputs
з
Ќ
*__inference_dense_61_layer_call_fn_2218465

inputs
unknown:
	unknown_0:
identityѕбStatefulPartitionedCallш
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         *$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8ѓ *N
fIRG
E__inference_dense_61_layer_call_and_return_conditional_losses_22181832
StatefulPartitionedCall{
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:         2

Identityh
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:         : : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:         
 
_user_specified_nameinputs
ј
Ш
E__inference_dense_61_layer_call_and_return_conditional_losses_2218476

inputs0
matmul_readvariableop_resource:-
biasadd_readvariableop_resource:
identityѕбBiasAdd/ReadVariableOpбMatMul/ReadVariableOpЇ
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:*
dtype02
MatMul/ReadVariableOps
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
MatMulї
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype02
BiasAdd/ReadVariableOpЂ
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2	
BiasAdd^
	LeakyRelu	LeakyReluBiasAdd:output:0*'
_output_shapes
:         2
	LeakyRelur
IdentityIdentityLeakyRelu:activations:0^NoOp*
T0*'
_output_shapes
:         2

Identity
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:         : : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:         
 
_user_specified_nameinputs
ћ&
Ў
H__inference_rank_net_20_layer_call_and_return_conditional_losses_2218221

inputs
inputs_1"
dense_60_2218164:
dense_60_2218166:"
dense_61_2218184:
dense_61_2218186:"
dense_62_2218203:
dense_62_2218205:
identityѕб dense_60/StatefulPartitionedCallб"dense_60/StatefulPartitionedCall_1б dense_61/StatefulPartitionedCallб"dense_61/StatefulPartitionedCall_1б dense_62/StatefulPartitionedCallб"dense_62/StatefulPartitionedCall_1Ќ
 dense_60/StatefulPartitionedCallStatefulPartitionedCallinputsdense_60_2218164dense_60_2218166*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         *$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8ѓ *N
fIRG
E__inference_dense_60_layer_call_and_return_conditional_losses_22181632"
 dense_60/StatefulPartitionedCallЮ
"dense_60/StatefulPartitionedCall_1StatefulPartitionedCallinputs_1dense_60_2218164dense_60_2218166*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         *$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8ѓ *N
fIRG
E__inference_dense_60_layer_call_and_return_conditional_losses_22181632$
"dense_60/StatefulPartitionedCall_1║
 dense_61/StatefulPartitionedCallStatefulPartitionedCall)dense_60/StatefulPartitionedCall:output:0dense_61_2218184dense_61_2218186*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         *$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8ѓ *N
fIRG
E__inference_dense_61_layer_call_and_return_conditional_losses_22181832"
 dense_61/StatefulPartitionedCall└
"dense_61/StatefulPartitionedCall_1StatefulPartitionedCall+dense_60/StatefulPartitionedCall_1:output:0dense_61_2218184dense_61_2218186*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         *$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8ѓ *N
fIRG
E__inference_dense_61_layer_call_and_return_conditional_losses_22181832$
"dense_61/StatefulPartitionedCall_1║
 dense_62/StatefulPartitionedCallStatefulPartitionedCall)dense_61/StatefulPartitionedCall:output:0dense_62_2218203dense_62_2218205*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         *$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8ѓ *N
fIRG
E__inference_dense_62_layer_call_and_return_conditional_losses_22182022"
 dense_62/StatefulPartitionedCall└
"dense_62/StatefulPartitionedCall_1StatefulPartitionedCall+dense_61/StatefulPartitionedCall_1:output:0dense_62_2218203dense_62_2218205*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         *$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8ѓ *N
fIRG
E__inference_dense_62_layer_call_and_return_conditional_losses_22182022$
"dense_62/StatefulPartitionedCall_1»
subtract_20/PartitionedCallPartitionedCall)dense_62/StatefulPartitionedCall:output:0+dense_62/StatefulPartitionedCall_1:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8ѓ *Q
fLRJ
H__inference_subtract_20_layer_call_and_return_conditional_losses_22182172
subtract_20/PartitionedCallІ
activation/SigmoidSigmoid$subtract_20/PartitionedCall:output:0*
T0*'
_output_shapes
:         2
activation/Sigmoidq
IdentityIdentityactivation/Sigmoid:y:0^NoOp*
T0*'
_output_shapes
:         2

Identityд
NoOpNoOp!^dense_60/StatefulPartitionedCall#^dense_60/StatefulPartitionedCall_1!^dense_61/StatefulPartitionedCall#^dense_61/StatefulPartitionedCall_1!^dense_62/StatefulPartitionedCall#^dense_62/StatefulPartitionedCall_1*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*E
_input_shapes4
2:         :         : : : : : : 2D
 dense_60/StatefulPartitionedCall dense_60/StatefulPartitionedCall2H
"dense_60/StatefulPartitionedCall_1"dense_60/StatefulPartitionedCall_12D
 dense_61/StatefulPartitionedCall dense_61/StatefulPartitionedCall2H
"dense_61/StatefulPartitionedCall_1"dense_61/StatefulPartitionedCall_12D
 dense_62/StatefulPartitionedCall dense_62/StatefulPartitionedCall2H
"dense_62/StatefulPartitionedCall_1"dense_62/StatefulPartitionedCall_1:O K
'
_output_shapes
:         
 
_user_specified_nameinputs:OK
'
_output_shapes
:         
 
_user_specified_nameinputs
Д>
г
#__inference__traced_restore_2218594
file_prefix>
,assignvariableop_rank_net_20_dense_62_kernel::
,assignvariableop_1_rank_net_20_dense_62_bias:%
assignvariableop_2_sgd_iter:	 &
assignvariableop_3_sgd_decay: .
$assignvariableop_4_sgd_learning_rate: )
assignvariableop_5_sgd_momentum: @
.assignvariableop_6_rank_net_20_dense_60_kernel::
,assignvariableop_7_rank_net_20_dense_60_bias:@
.assignvariableop_8_rank_net_20_dense_61_kernel::
,assignvariableop_9_rank_net_20_dense_61_bias:#
assignvariableop_10_total: #
assignvariableop_11_count: %
assignvariableop_12_total_1: %
assignvariableop_13_count_1: 
identity_15ѕбAssignVariableOpбAssignVariableOp_1бAssignVariableOp_10бAssignVariableOp_11бAssignVariableOp_12бAssignVariableOp_13бAssignVariableOp_2бAssignVariableOp_3бAssignVariableOp_4бAssignVariableOp_5бAssignVariableOp_6бAssignVariableOp_7бAssignVariableOp_8бAssignVariableOp_9╔
RestoreV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*Н
value╦B╚B#o/kernel/.ATTRIBUTES/VARIABLE_VALUEB!o/bias/.ATTRIBUTES/VARIABLE_VALUEB)optimizer/iter/.ATTRIBUTES/VARIABLE_VALUEB*optimizer/decay/.ATTRIBUTES/VARIABLE_VALUEB2optimizer/learning_rate/.ATTRIBUTES/VARIABLE_VALUEB-optimizer/momentum/.ATTRIBUTES/VARIABLE_VALUEB0trainable_variables/0/.ATTRIBUTES/VARIABLE_VALUEB0trainable_variables/1/.ATTRIBUTES/VARIABLE_VALUEB0trainable_variables/2/.ATTRIBUTES/VARIABLE_VALUEB0trainable_variables/3/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/count/.ATTRIBUTES/VARIABLE_VALUEB_CHECKPOINTABLE_OBJECT_GRAPH2
RestoreV2/tensor_namesг
RestoreV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*1
value(B&B B B B B B B B B B B B B B B 2
RestoreV2/shape_and_slicesШ
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

IdentityФ
AssignVariableOpAssignVariableOp,assignvariableop_rank_net_20_dense_62_kernelIdentity:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOpk

Identity_1IdentityRestoreV2:tensors:1"/device:CPU:0*
T0*
_output_shapes
:2

Identity_1▒
AssignVariableOp_1AssignVariableOp,assignvariableop_1_rank_net_20_dense_62_biasIdentity_1:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_1k

Identity_2IdentityRestoreV2:tensors:2"/device:CPU:0*
T0	*
_output_shapes
:2

Identity_2а
AssignVariableOp_2AssignVariableOpassignvariableop_2_sgd_iterIdentity_2:output:0"/device:CPU:0*
_output_shapes
 *
dtype0	2
AssignVariableOp_2k

Identity_3IdentityRestoreV2:tensors:3"/device:CPU:0*
T0*
_output_shapes
:2

Identity_3А
AssignVariableOp_3AssignVariableOpassignvariableop_3_sgd_decayIdentity_3:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_3k

Identity_4IdentityRestoreV2:tensors:4"/device:CPU:0*
T0*
_output_shapes
:2

Identity_4Е
AssignVariableOp_4AssignVariableOp$assignvariableop_4_sgd_learning_rateIdentity_4:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_4k

Identity_5IdentityRestoreV2:tensors:5"/device:CPU:0*
T0*
_output_shapes
:2

Identity_5ц
AssignVariableOp_5AssignVariableOpassignvariableop_5_sgd_momentumIdentity_5:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_5k

Identity_6IdentityRestoreV2:tensors:6"/device:CPU:0*
T0*
_output_shapes
:2

Identity_6│
AssignVariableOp_6AssignVariableOp.assignvariableop_6_rank_net_20_dense_60_kernelIdentity_6:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_6k

Identity_7IdentityRestoreV2:tensors:7"/device:CPU:0*
T0*
_output_shapes
:2

Identity_7▒
AssignVariableOp_7AssignVariableOp,assignvariableop_7_rank_net_20_dense_60_biasIdentity_7:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_7k

Identity_8IdentityRestoreV2:tensors:8"/device:CPU:0*
T0*
_output_shapes
:2

Identity_8│
AssignVariableOp_8AssignVariableOp.assignvariableop_8_rank_net_20_dense_61_kernelIdentity_8:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_8k

Identity_9IdentityRestoreV2:tensors:9"/device:CPU:0*
T0*
_output_shapes
:2

Identity_9▒
AssignVariableOp_9AssignVariableOp,assignvariableop_9_rank_net_20_dense_61_biasIdentity_9:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_9n
Identity_10IdentityRestoreV2:tensors:10"/device:CPU:0*
T0*
_output_shapes
:2
Identity_10А
AssignVariableOp_10AssignVariableOpassignvariableop_10_totalIdentity_10:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_10n
Identity_11IdentityRestoreV2:tensors:11"/device:CPU:0*
T0*
_output_shapes
:2
Identity_11А
AssignVariableOp_11AssignVariableOpassignvariableop_11_countIdentity_11:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_11n
Identity_12IdentityRestoreV2:tensors:12"/device:CPU:0*
T0*
_output_shapes
:2
Identity_12Б
AssignVariableOp_12AssignVariableOpassignvariableop_12_total_1Identity_12:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_12n
Identity_13IdentityRestoreV2:tensors:13"/device:CPU:0*
T0*
_output_shapes
:2
Identity_13Б
AssignVariableOp_13AssignVariableOpassignvariableop_13_count_1Identity_13:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_139
NoOpNoOp"/device:CPU:0*
_output_shapes
 2
NoOpњ
Identity_14Identityfile_prefix^AssignVariableOp^AssignVariableOp_1^AssignVariableOp_10^AssignVariableOp_11^AssignVariableOp_12^AssignVariableOp_13^AssignVariableOp_2^AssignVariableOp_3^AssignVariableOp_4^AssignVariableOp_5^AssignVariableOp_6^AssignVariableOp_7^AssignVariableOp_8^AssignVariableOp_9^NoOp"/device:CPU:0*
T0*
_output_shapes
: 2
Identity_14f
Identity_15IdentityIdentity_14:output:0^NoOp_1*
T0*
_output_shapes
: 2
Identity_15Щ
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
Н:
Ь
H__inference_rank_net_20_layer_call_and_return_conditional_losses_2218405
inputs_0
inputs_19
'dense_60_matmul_readvariableop_resource:6
(dense_60_biasadd_readvariableop_resource:9
'dense_61_matmul_readvariableop_resource:6
(dense_61_biasadd_readvariableop_resource:9
'dense_62_matmul_readvariableop_resource:6
(dense_62_biasadd_readvariableop_resource:
identityѕбdense_60/BiasAdd/ReadVariableOpб!dense_60/BiasAdd_1/ReadVariableOpбdense_60/MatMul/ReadVariableOpб dense_60/MatMul_1/ReadVariableOpбdense_61/BiasAdd/ReadVariableOpб!dense_61/BiasAdd_1/ReadVariableOpбdense_61/MatMul/ReadVariableOpб dense_61/MatMul_1/ReadVariableOpбdense_62/BiasAdd/ReadVariableOpб!dense_62/BiasAdd_1/ReadVariableOpбdense_62/MatMul/ReadVariableOpб dense_62/MatMul_1/ReadVariableOpе
dense_60/MatMul/ReadVariableOpReadVariableOp'dense_60_matmul_readvariableop_resource*
_output_shapes

:*
dtype02 
dense_60/MatMul/ReadVariableOpљ
dense_60/MatMulMatMulinputs_0&dense_60/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
dense_60/MatMulД
dense_60/BiasAdd/ReadVariableOpReadVariableOp(dense_60_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02!
dense_60/BiasAdd/ReadVariableOpЦ
dense_60/BiasAddBiasAdddense_60/MatMul:product:0'dense_60/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
dense_60/BiasAddy
dense_60/LeakyRelu	LeakyReludense_60/BiasAdd:output:0*'
_output_shapes
:         2
dense_60/LeakyReluг
 dense_60/MatMul_1/ReadVariableOpReadVariableOp'dense_60_matmul_readvariableop_resource*
_output_shapes

:*
dtype02"
 dense_60/MatMul_1/ReadVariableOpќ
dense_60/MatMul_1MatMulinputs_1(dense_60/MatMul_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
dense_60/MatMul_1Ф
!dense_60/BiasAdd_1/ReadVariableOpReadVariableOp(dense_60_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02#
!dense_60/BiasAdd_1/ReadVariableOpГ
dense_60/BiasAdd_1BiasAdddense_60/MatMul_1:product:0)dense_60/BiasAdd_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
dense_60/BiasAdd_1
dense_60/LeakyRelu_1	LeakyReludense_60/BiasAdd_1:output:0*'
_output_shapes
:         2
dense_60/LeakyRelu_1е
dense_61/MatMul/ReadVariableOpReadVariableOp'dense_61_matmul_readvariableop_resource*
_output_shapes

:*
dtype02 
dense_61/MatMul/ReadVariableOpе
dense_61/MatMulMatMul dense_60/LeakyRelu:activations:0&dense_61/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
dense_61/MatMulД
dense_61/BiasAdd/ReadVariableOpReadVariableOp(dense_61_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02!
dense_61/BiasAdd/ReadVariableOpЦ
dense_61/BiasAddBiasAdddense_61/MatMul:product:0'dense_61/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
dense_61/BiasAddy
dense_61/LeakyRelu	LeakyReludense_61/BiasAdd:output:0*'
_output_shapes
:         2
dense_61/LeakyReluг
 dense_61/MatMul_1/ReadVariableOpReadVariableOp'dense_61_matmul_readvariableop_resource*
_output_shapes

:*
dtype02"
 dense_61/MatMul_1/ReadVariableOp░
dense_61/MatMul_1MatMul"dense_60/LeakyRelu_1:activations:0(dense_61/MatMul_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
dense_61/MatMul_1Ф
!dense_61/BiasAdd_1/ReadVariableOpReadVariableOp(dense_61_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02#
!dense_61/BiasAdd_1/ReadVariableOpГ
dense_61/BiasAdd_1BiasAdddense_61/MatMul_1:product:0)dense_61/BiasAdd_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
dense_61/BiasAdd_1
dense_61/LeakyRelu_1	LeakyReludense_61/BiasAdd_1:output:0*'
_output_shapes
:         2
dense_61/LeakyRelu_1е
dense_62/MatMul/ReadVariableOpReadVariableOp'dense_62_matmul_readvariableop_resource*
_output_shapes

:*
dtype02 
dense_62/MatMul/ReadVariableOpе
dense_62/MatMulMatMul dense_61/LeakyRelu:activations:0&dense_62/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
dense_62/MatMulД
dense_62/BiasAdd/ReadVariableOpReadVariableOp(dense_62_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02!
dense_62/BiasAdd/ReadVariableOpЦ
dense_62/BiasAddBiasAdddense_62/MatMul:product:0'dense_62/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
dense_62/BiasAddг
 dense_62/MatMul_1/ReadVariableOpReadVariableOp'dense_62_matmul_readvariableop_resource*
_output_shapes

:*
dtype02"
 dense_62/MatMul_1/ReadVariableOp░
dense_62/MatMul_1MatMul"dense_61/LeakyRelu_1:activations:0(dense_62/MatMul_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
dense_62/MatMul_1Ф
!dense_62/BiasAdd_1/ReadVariableOpReadVariableOp(dense_62_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02#
!dense_62/BiasAdd_1/ReadVariableOpГ
dense_62/BiasAdd_1BiasAdddense_62/MatMul_1:product:0)dense_62/BiasAdd_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
dense_62/BiasAdd_1Њ
subtract_20/subSubdense_62/BiasAdd:output:0dense_62/BiasAdd_1:output:0*
T0*'
_output_shapes
:         2
subtract_20/subz
activation/SigmoidSigmoidsubtract_20/sub:z:0*
T0*'
_output_shapes
:         2
activation/Sigmoidq
IdentityIdentityactivation/Sigmoid:y:0^NoOp*
T0*'
_output_shapes
:         2

IdentityВ
NoOpNoOp ^dense_60/BiasAdd/ReadVariableOp"^dense_60/BiasAdd_1/ReadVariableOp^dense_60/MatMul/ReadVariableOp!^dense_60/MatMul_1/ReadVariableOp ^dense_61/BiasAdd/ReadVariableOp"^dense_61/BiasAdd_1/ReadVariableOp^dense_61/MatMul/ReadVariableOp!^dense_61/MatMul_1/ReadVariableOp ^dense_62/BiasAdd/ReadVariableOp"^dense_62/BiasAdd_1/ReadVariableOp^dense_62/MatMul/ReadVariableOp!^dense_62/MatMul_1/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*E
_input_shapes4
2:         :         : : : : : : 2B
dense_60/BiasAdd/ReadVariableOpdense_60/BiasAdd/ReadVariableOp2F
!dense_60/BiasAdd_1/ReadVariableOp!dense_60/BiasAdd_1/ReadVariableOp2@
dense_60/MatMul/ReadVariableOpdense_60/MatMul/ReadVariableOp2D
 dense_60/MatMul_1/ReadVariableOp dense_60/MatMul_1/ReadVariableOp2B
dense_61/BiasAdd/ReadVariableOpdense_61/BiasAdd/ReadVariableOp2F
!dense_61/BiasAdd_1/ReadVariableOp!dense_61/BiasAdd_1/ReadVariableOp2@
dense_61/MatMul/ReadVariableOpdense_61/MatMul/ReadVariableOp2D
 dense_61/MatMul_1/ReadVariableOp dense_61/MatMul_1/ReadVariableOp2B
dense_62/BiasAdd/ReadVariableOpdense_62/BiasAdd/ReadVariableOp2F
!dense_62/BiasAdd_1/ReadVariableOp!dense_62/BiasAdd_1/ReadVariableOp2@
dense_62/MatMul/ReadVariableOpdense_62/MatMul/ReadVariableOp2D
 dense_62/MatMul_1/ReadVariableOp dense_62/MatMul_1/ReadVariableOp:Q M
'
_output_shapes
:         
"
_user_specified_name
inputs/0:QM
'
_output_shapes
:         
"
_user_specified_name
inputs/1
ќ&
Ў
H__inference_rank_net_20_layer_call_and_return_conditional_losses_2218322
input_1
input_2"
dense_60_2218295:
dense_60_2218297:"
dense_61_2218303:
dense_61_2218305:"
dense_62_2218311:
dense_62_2218313:
identityѕб dense_60/StatefulPartitionedCallб"dense_60/StatefulPartitionedCall_1б dense_61/StatefulPartitionedCallб"dense_61/StatefulPartitionedCall_1б dense_62/StatefulPartitionedCallб"dense_62/StatefulPartitionedCall_1ў
 dense_60/StatefulPartitionedCallStatefulPartitionedCallinput_1dense_60_2218295dense_60_2218297*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         *$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8ѓ *N
fIRG
E__inference_dense_60_layer_call_and_return_conditional_losses_22181632"
 dense_60/StatefulPartitionedCallю
"dense_60/StatefulPartitionedCall_1StatefulPartitionedCallinput_2dense_60_2218295dense_60_2218297*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         *$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8ѓ *N
fIRG
E__inference_dense_60_layer_call_and_return_conditional_losses_22181632$
"dense_60/StatefulPartitionedCall_1║
 dense_61/StatefulPartitionedCallStatefulPartitionedCall)dense_60/StatefulPartitionedCall:output:0dense_61_2218303dense_61_2218305*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         *$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8ѓ *N
fIRG
E__inference_dense_61_layer_call_and_return_conditional_losses_22181832"
 dense_61/StatefulPartitionedCall└
"dense_61/StatefulPartitionedCall_1StatefulPartitionedCall+dense_60/StatefulPartitionedCall_1:output:0dense_61_2218303dense_61_2218305*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         *$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8ѓ *N
fIRG
E__inference_dense_61_layer_call_and_return_conditional_losses_22181832$
"dense_61/StatefulPartitionedCall_1║
 dense_62/StatefulPartitionedCallStatefulPartitionedCall)dense_61/StatefulPartitionedCall:output:0dense_62_2218311dense_62_2218313*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         *$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8ѓ *N
fIRG
E__inference_dense_62_layer_call_and_return_conditional_losses_22182022"
 dense_62/StatefulPartitionedCall└
"dense_62/StatefulPartitionedCall_1StatefulPartitionedCall+dense_61/StatefulPartitionedCall_1:output:0dense_62_2218311dense_62_2218313*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         *$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8ѓ *N
fIRG
E__inference_dense_62_layer_call_and_return_conditional_losses_22182022$
"dense_62/StatefulPartitionedCall_1»
subtract_20/PartitionedCallPartitionedCall)dense_62/StatefulPartitionedCall:output:0+dense_62/StatefulPartitionedCall_1:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8ѓ *Q
fLRJ
H__inference_subtract_20_layer_call_and_return_conditional_losses_22182172
subtract_20/PartitionedCallІ
activation/SigmoidSigmoid$subtract_20/PartitionedCall:output:0*
T0*'
_output_shapes
:         2
activation/Sigmoidq
IdentityIdentityactivation/Sigmoid:y:0^NoOp*
T0*'
_output_shapes
:         2

Identityд
NoOpNoOp!^dense_60/StatefulPartitionedCall#^dense_60/StatefulPartitionedCall_1!^dense_61/StatefulPartitionedCall#^dense_61/StatefulPartitionedCall_1!^dense_62/StatefulPartitionedCall#^dense_62/StatefulPartitionedCall_1*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*E
_input_shapes4
2:         :         : : : : : : 2D
 dense_60/StatefulPartitionedCall dense_60/StatefulPartitionedCall2H
"dense_60/StatefulPartitionedCall_1"dense_60/StatefulPartitionedCall_12D
 dense_61/StatefulPartitionedCall dense_61/StatefulPartitionedCall2H
"dense_61/StatefulPartitionedCall_1"dense_61/StatefulPartitionedCall_12D
 dense_62/StatefulPartitionedCall dense_62/StatefulPartitionedCall2H
"dense_62/StatefulPartitionedCall_1"dense_62/StatefulPartitionedCall_1:P L
'
_output_shapes
:         
!
_user_specified_name	input_1:PL
'
_output_shapes
:         
!
_user_specified_name	input_2
з
Ќ
*__inference_dense_60_layer_call_fn_2218445

inputs
unknown:
	unknown_0:
identityѕбStatefulPartitionedCallш
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         *$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8ѓ *N
fIRG
E__inference_dense_60_layer_call_and_return_conditional_losses_22181632
StatefulPartitionedCall{
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:         2

Identityh
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:         : : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:         
 
_user_specified_nameinputs
ј
Ш
E__inference_dense_61_layer_call_and_return_conditional_losses_2218183

inputs0
matmul_readvariableop_resource:-
biasadd_readvariableop_resource:
identityѕбBiasAdd/ReadVariableOpбMatMul/ReadVariableOpЇ
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:*
dtype02
MatMul/ReadVariableOps
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
MatMulї
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype02
BiasAdd/ReadVariableOpЂ
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2	
BiasAdd^
	LeakyRelu	LeakyReluBiasAdd:output:0*'
_output_shapes
:         2
	LeakyRelur
IdentityIdentityLeakyRelu:activations:0^NoOp*
T0*'
_output_shapes
:         2

Identity
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:         : : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:         
 
_user_specified_nameinputs
а

ћ
-__inference_rank_net_20_layer_call_fn_2218236
input_1
input_2
unknown:
	unknown_0:
	unknown_1:
	unknown_2:
	unknown_3:
	unknown_4:
identityѕбStatefulPartitionedCallи
StatefulPartitionedCallStatefulPartitionedCallinput_1input_2unknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4*
Tin

2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         *(
_read_only_resource_inputs

*-
config_proto

CPU

GPU 2J 8ѓ *Q
fLRJ
H__inference_rank_net_20_layer_call_and_return_conditional_losses_22182212
StatefulPartitionedCall{
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:         2

Identityh
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*E
_input_shapes4
2:         :         : : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:P L
'
_output_shapes
:         
!
_user_specified_name	input_1:PL
'
_output_shapes
:         
!
_user_specified_name	input_2
Д

Ш
E__inference_dense_62_layer_call_and_return_conditional_losses_2218202

inputs0
matmul_readvariableop_resource:-
biasadd_readvariableop_resource:
identityѕбBiasAdd/ReadVariableOpбMatMul/ReadVariableOpЇ
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:*
dtype02
MatMul/ReadVariableOps
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
MatMulї
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype02
BiasAdd/ReadVariableOpЂ
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2	
BiasAddk
IdentityIdentityBiasAdd:output:0^NoOp*
T0*'
_output_shapes
:         2

Identity
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:         : : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:         
 
_user_specified_nameinputs
д

ќ
-__inference_rank_net_20_layer_call_fn_2218364
inputs_0
inputs_1
unknown:
	unknown_0:
	unknown_1:
	unknown_2:
	unknown_3:
	unknown_4:
identityѕбStatefulPartitionedCall╣
StatefulPartitionedCallStatefulPartitionedCallinputs_0inputs_1unknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4*
Tin

2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         *(
_read_only_resource_inputs

*-
config_proto

CPU

GPU 2J 8ѓ *Q
fLRJ
H__inference_rank_net_20_layer_call_and_return_conditional_losses_22182212
StatefulPartitionedCall{
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:         2

Identityh
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*E
_input_shapes4
2:         :         : : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:Q M
'
_output_shapes
:         
"
_user_specified_name
inputs/0:QM
'
_output_shapes
:         
"
_user_specified_name
inputs/1
╔
Y
-__inference_subtract_20_layer_call_fn_2218430
inputs_0
inputs_1
identityМ
PartitionedCallPartitionedCallinputs_0inputs_1*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8ѓ *Q
fLRJ
H__inference_subtract_20_layer_call_and_return_conditional_losses_22182172
PartitionedCalll
IdentityIdentityPartitionedCall:output:0*
T0*'
_output_shapes
:         2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*9
_input_shapes(
&:         :         :Q M
'
_output_shapes
:         
"
_user_specified_name
inputs/0:QM
'
_output_shapes
:         
"
_user_specified_name
inputs/1
■H
ъ
"__inference__wrapped_model_2218143
input_1
input_2E
3rank_net_20_dense_60_matmul_readvariableop_resource:B
4rank_net_20_dense_60_biasadd_readvariableop_resource:E
3rank_net_20_dense_61_matmul_readvariableop_resource:B
4rank_net_20_dense_61_biasadd_readvariableop_resource:E
3rank_net_20_dense_62_matmul_readvariableop_resource:B
4rank_net_20_dense_62_biasadd_readvariableop_resource:
identityѕб+rank_net_20/dense_60/BiasAdd/ReadVariableOpб-rank_net_20/dense_60/BiasAdd_1/ReadVariableOpб*rank_net_20/dense_60/MatMul/ReadVariableOpб,rank_net_20/dense_60/MatMul_1/ReadVariableOpб+rank_net_20/dense_61/BiasAdd/ReadVariableOpб-rank_net_20/dense_61/BiasAdd_1/ReadVariableOpб*rank_net_20/dense_61/MatMul/ReadVariableOpб,rank_net_20/dense_61/MatMul_1/ReadVariableOpб+rank_net_20/dense_62/BiasAdd/ReadVariableOpб-rank_net_20/dense_62/BiasAdd_1/ReadVariableOpб*rank_net_20/dense_62/MatMul/ReadVariableOpб,rank_net_20/dense_62/MatMul_1/ReadVariableOp╠
*rank_net_20/dense_60/MatMul/ReadVariableOpReadVariableOp3rank_net_20_dense_60_matmul_readvariableop_resource*
_output_shapes

:*
dtype02,
*rank_net_20/dense_60/MatMul/ReadVariableOp│
rank_net_20/dense_60/MatMulMatMulinput_12rank_net_20/dense_60/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
rank_net_20/dense_60/MatMul╦
+rank_net_20/dense_60/BiasAdd/ReadVariableOpReadVariableOp4rank_net_20_dense_60_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02-
+rank_net_20/dense_60/BiasAdd/ReadVariableOpН
rank_net_20/dense_60/BiasAddBiasAdd%rank_net_20/dense_60/MatMul:product:03rank_net_20/dense_60/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
rank_net_20/dense_60/BiasAddЮ
rank_net_20/dense_60/LeakyRelu	LeakyRelu%rank_net_20/dense_60/BiasAdd:output:0*'
_output_shapes
:         2 
rank_net_20/dense_60/LeakyReluл
,rank_net_20/dense_60/MatMul_1/ReadVariableOpReadVariableOp3rank_net_20_dense_60_matmul_readvariableop_resource*
_output_shapes

:*
dtype02.
,rank_net_20/dense_60/MatMul_1/ReadVariableOp╣
rank_net_20/dense_60/MatMul_1MatMulinput_24rank_net_20/dense_60/MatMul_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
rank_net_20/dense_60/MatMul_1¤
-rank_net_20/dense_60/BiasAdd_1/ReadVariableOpReadVariableOp4rank_net_20_dense_60_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02/
-rank_net_20/dense_60/BiasAdd_1/ReadVariableOpП
rank_net_20/dense_60/BiasAdd_1BiasAdd'rank_net_20/dense_60/MatMul_1:product:05rank_net_20/dense_60/BiasAdd_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2 
rank_net_20/dense_60/BiasAdd_1Б
 rank_net_20/dense_60/LeakyRelu_1	LeakyRelu'rank_net_20/dense_60/BiasAdd_1:output:0*'
_output_shapes
:         2"
 rank_net_20/dense_60/LeakyRelu_1╠
*rank_net_20/dense_61/MatMul/ReadVariableOpReadVariableOp3rank_net_20_dense_61_matmul_readvariableop_resource*
_output_shapes

:*
dtype02,
*rank_net_20/dense_61/MatMul/ReadVariableOpп
rank_net_20/dense_61/MatMulMatMul,rank_net_20/dense_60/LeakyRelu:activations:02rank_net_20/dense_61/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
rank_net_20/dense_61/MatMul╦
+rank_net_20/dense_61/BiasAdd/ReadVariableOpReadVariableOp4rank_net_20_dense_61_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02-
+rank_net_20/dense_61/BiasAdd/ReadVariableOpН
rank_net_20/dense_61/BiasAddBiasAdd%rank_net_20/dense_61/MatMul:product:03rank_net_20/dense_61/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
rank_net_20/dense_61/BiasAddЮ
rank_net_20/dense_61/LeakyRelu	LeakyRelu%rank_net_20/dense_61/BiasAdd:output:0*'
_output_shapes
:         2 
rank_net_20/dense_61/LeakyReluл
,rank_net_20/dense_61/MatMul_1/ReadVariableOpReadVariableOp3rank_net_20_dense_61_matmul_readvariableop_resource*
_output_shapes

:*
dtype02.
,rank_net_20/dense_61/MatMul_1/ReadVariableOpЯ
rank_net_20/dense_61/MatMul_1MatMul.rank_net_20/dense_60/LeakyRelu_1:activations:04rank_net_20/dense_61/MatMul_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
rank_net_20/dense_61/MatMul_1¤
-rank_net_20/dense_61/BiasAdd_1/ReadVariableOpReadVariableOp4rank_net_20_dense_61_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02/
-rank_net_20/dense_61/BiasAdd_1/ReadVariableOpП
rank_net_20/dense_61/BiasAdd_1BiasAdd'rank_net_20/dense_61/MatMul_1:product:05rank_net_20/dense_61/BiasAdd_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2 
rank_net_20/dense_61/BiasAdd_1Б
 rank_net_20/dense_61/LeakyRelu_1	LeakyRelu'rank_net_20/dense_61/BiasAdd_1:output:0*'
_output_shapes
:         2"
 rank_net_20/dense_61/LeakyRelu_1╠
*rank_net_20/dense_62/MatMul/ReadVariableOpReadVariableOp3rank_net_20_dense_62_matmul_readvariableop_resource*
_output_shapes

:*
dtype02,
*rank_net_20/dense_62/MatMul/ReadVariableOpп
rank_net_20/dense_62/MatMulMatMul,rank_net_20/dense_61/LeakyRelu:activations:02rank_net_20/dense_62/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
rank_net_20/dense_62/MatMul╦
+rank_net_20/dense_62/BiasAdd/ReadVariableOpReadVariableOp4rank_net_20_dense_62_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02-
+rank_net_20/dense_62/BiasAdd/ReadVariableOpН
rank_net_20/dense_62/BiasAddBiasAdd%rank_net_20/dense_62/MatMul:product:03rank_net_20/dense_62/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
rank_net_20/dense_62/BiasAddл
,rank_net_20/dense_62/MatMul_1/ReadVariableOpReadVariableOp3rank_net_20_dense_62_matmul_readvariableop_resource*
_output_shapes

:*
dtype02.
,rank_net_20/dense_62/MatMul_1/ReadVariableOpЯ
rank_net_20/dense_62/MatMul_1MatMul.rank_net_20/dense_61/LeakyRelu_1:activations:04rank_net_20/dense_62/MatMul_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2
rank_net_20/dense_62/MatMul_1¤
-rank_net_20/dense_62/BiasAdd_1/ReadVariableOpReadVariableOp4rank_net_20_dense_62_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02/
-rank_net_20/dense_62/BiasAdd_1/ReadVariableOpП
rank_net_20/dense_62/BiasAdd_1BiasAdd'rank_net_20/dense_62/MatMul_1:product:05rank_net_20/dense_62/BiasAdd_1/ReadVariableOp:value:0*
T0*'
_output_shapes
:         2 
rank_net_20/dense_62/BiasAdd_1├
rank_net_20/subtract_20/subSub%rank_net_20/dense_62/BiasAdd:output:0'rank_net_20/dense_62/BiasAdd_1:output:0*
T0*'
_output_shapes
:         2
rank_net_20/subtract_20/subъ
rank_net_20/activation/SigmoidSigmoidrank_net_20/subtract_20/sub:z:0*
T0*'
_output_shapes
:         2 
rank_net_20/activation/Sigmoid}
IdentityIdentity"rank_net_20/activation/Sigmoid:y:0^NoOp*
T0*'
_output_shapes
:         2

IdentityЧ
NoOpNoOp,^rank_net_20/dense_60/BiasAdd/ReadVariableOp.^rank_net_20/dense_60/BiasAdd_1/ReadVariableOp+^rank_net_20/dense_60/MatMul/ReadVariableOp-^rank_net_20/dense_60/MatMul_1/ReadVariableOp,^rank_net_20/dense_61/BiasAdd/ReadVariableOp.^rank_net_20/dense_61/BiasAdd_1/ReadVariableOp+^rank_net_20/dense_61/MatMul/ReadVariableOp-^rank_net_20/dense_61/MatMul_1/ReadVariableOp,^rank_net_20/dense_62/BiasAdd/ReadVariableOp.^rank_net_20/dense_62/BiasAdd_1/ReadVariableOp+^rank_net_20/dense_62/MatMul/ReadVariableOp-^rank_net_20/dense_62/MatMul_1/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*E
_input_shapes4
2:         :         : : : : : : 2Z
+rank_net_20/dense_60/BiasAdd/ReadVariableOp+rank_net_20/dense_60/BiasAdd/ReadVariableOp2^
-rank_net_20/dense_60/BiasAdd_1/ReadVariableOp-rank_net_20/dense_60/BiasAdd_1/ReadVariableOp2X
*rank_net_20/dense_60/MatMul/ReadVariableOp*rank_net_20/dense_60/MatMul/ReadVariableOp2\
,rank_net_20/dense_60/MatMul_1/ReadVariableOp,rank_net_20/dense_60/MatMul_1/ReadVariableOp2Z
+rank_net_20/dense_61/BiasAdd/ReadVariableOp+rank_net_20/dense_61/BiasAdd/ReadVariableOp2^
-rank_net_20/dense_61/BiasAdd_1/ReadVariableOp-rank_net_20/dense_61/BiasAdd_1/ReadVariableOp2X
*rank_net_20/dense_61/MatMul/ReadVariableOp*rank_net_20/dense_61/MatMul/ReadVariableOp2\
,rank_net_20/dense_61/MatMul_1/ReadVariableOp,rank_net_20/dense_61/MatMul_1/ReadVariableOp2Z
+rank_net_20/dense_62/BiasAdd/ReadVariableOp+rank_net_20/dense_62/BiasAdd/ReadVariableOp2^
-rank_net_20/dense_62/BiasAdd_1/ReadVariableOp-rank_net_20/dense_62/BiasAdd_1/ReadVariableOp2X
*rank_net_20/dense_62/MatMul/ReadVariableOp*rank_net_20/dense_62/MatMul/ReadVariableOp2\
,rank_net_20/dense_62/MatMul_1/ReadVariableOp,rank_net_20/dense_62/MatMul_1/ReadVariableOp:P L
'
_output_shapes
:         
!
_user_specified_name	input_1:PL
'
_output_shapes
:         
!
_user_specified_name	input_2
Г'
Ю
 __inference__traced_save_2218542
file_prefix:
6savev2_rank_net_20_dense_62_kernel_read_readvariableop8
4savev2_rank_net_20_dense_62_bias_read_readvariableop'
#savev2_sgd_iter_read_readvariableop	(
$savev2_sgd_decay_read_readvariableop0
,savev2_sgd_learning_rate_read_readvariableop+
'savev2_sgd_momentum_read_readvariableop:
6savev2_rank_net_20_dense_60_kernel_read_readvariableop8
4savev2_rank_net_20_dense_60_bias_read_readvariableop:
6savev2_rank_net_20_dense_61_kernel_read_readvariableop8
4savev2_rank_net_20_dense_61_bias_read_readvariableop$
 savev2_total_read_readvariableop$
 savev2_count_read_readvariableop&
"savev2_total_1_read_readvariableop&
"savev2_count_1_read_readvariableop
savev2_const

identity_1ѕбMergeV2CheckpointsЈ
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
Const_1І
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
ShardedFilename/shardд
ShardedFilenameShardedFilenameStringJoin:output:0ShardedFilename/shard:output:0num_shards:output:0"/device:CPU:0*
_output_shapes
: 2
ShardedFilename├
SaveV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*Н
value╦B╚B#o/kernel/.ATTRIBUTES/VARIABLE_VALUEB!o/bias/.ATTRIBUTES/VARIABLE_VALUEB)optimizer/iter/.ATTRIBUTES/VARIABLE_VALUEB*optimizer/decay/.ATTRIBUTES/VARIABLE_VALUEB2optimizer/learning_rate/.ATTRIBUTES/VARIABLE_VALUEB-optimizer/momentum/.ATTRIBUTES/VARIABLE_VALUEB0trainable_variables/0/.ATTRIBUTES/VARIABLE_VALUEB0trainable_variables/1/.ATTRIBUTES/VARIABLE_VALUEB0trainable_variables/2/.ATTRIBUTES/VARIABLE_VALUEB0trainable_variables/3/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/count/.ATTRIBUTES/VARIABLE_VALUEB_CHECKPOINTABLE_OBJECT_GRAPH2
SaveV2/tensor_namesд
SaveV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*1
value(B&B B B B B B B B B B B B B B B 2
SaveV2/shape_and_slices└
SaveV2SaveV2ShardedFilename:filename:0SaveV2/tensor_names:output:0 SaveV2/shape_and_slices:output:06savev2_rank_net_20_dense_62_kernel_read_readvariableop4savev2_rank_net_20_dense_62_bias_read_readvariableop#savev2_sgd_iter_read_readvariableop$savev2_sgd_decay_read_readvariableop,savev2_sgd_learning_rate_read_readvariableop'savev2_sgd_momentum_read_readvariableop6savev2_rank_net_20_dense_60_kernel_read_readvariableop4savev2_rank_net_20_dense_60_bias_read_readvariableop6savev2_rank_net_20_dense_61_kernel_read_readvariableop4savev2_rank_net_20_dense_61_bias_read_readvariableop savev2_total_read_readvariableop savev2_count_read_readvariableop"savev2_total_1_read_readvariableop"savev2_count_1_read_readvariableopsavev2_const"/device:CPU:0*
_output_shapes
 *
dtypes
2	2
SaveV2║
&MergeV2Checkpoints/checkpoint_prefixesPackShardedFilename:filename:0^SaveV2"/device:CPU:0*
N*
T0*
_output_shapes
:2(
&MergeV2Checkpoints/checkpoint_prefixesА
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
Ы	
ї
%__inference_signature_wrapper_2218346
input_1
input_2
unknown:
	unknown_0:
	unknown_1:
	unknown_2:
	unknown_3:
	unknown_4:
identityѕбStatefulPartitionedCallЉ
StatefulPartitionedCallStatefulPartitionedCallinput_1input_2unknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4*
Tin

2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:         *(
_read_only_resource_inputs

*-
config_proto

CPU

GPU 2J 8ѓ *+
f&R$
"__inference__wrapped_model_22181432
StatefulPartitionedCall{
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:         2

Identityh
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*E
_input_shapes4
2:         :         : : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:P L
'
_output_shapes
:         
!
_user_specified_name	input_1:PL
'
_output_shapes
:         
!
_user_specified_name	input_2
о
t
H__inference_subtract_20_layer_call_and_return_conditional_losses_2218436
inputs_0
inputs_1
identityW
subSubinputs_0inputs_1*
T0*'
_output_shapes
:         2
sub[
IdentityIdentitysub:z:0*
T0*'
_output_shapes
:         2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*9
_input_shapes(
&:         :         :Q M
'
_output_shapes
:         
"
_user_specified_name
inputs/0:QM
'
_output_shapes
:         
"
_user_specified_name
inputs/1
╬
r
H__inference_subtract_20_layer_call_and_return_conditional_losses_2218217

inputs
inputs_1
identityU
subSubinputsinputs_1*
T0*'
_output_shapes
:         2
sub[
IdentityIdentitysub:z:0*
T0*'
_output_shapes
:         2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*9
_input_shapes(
&:         :         :O K
'
_output_shapes
:         
 
_user_specified_nameinputs:OK
'
_output_shapes
:         
 
_user_specified_nameinputs"еL
saver_filename:0StatefulPartitionedCall_1:0StatefulPartitionedCall_28"
saved_model_main_op

NoOp*>
__saved_model_init_op%#
__saved_model_init_op

NoOp*У
serving_defaultн
;
input_10
serving_default_input_1:0         
;
input_20
serving_default_input_2:0         <
output_10
StatefulPartitionedCall:0         tensorflow/serving/predict:┬Q
ё
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
╗

kernel
bias
trainable_variables
regularization_losses
	variables
	keras_api
M__call__
*N&call_and_return_all_conditional_losses"
_tf_keras_layer
Ц
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
╩
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
╗

kernel
bias
#trainable_variables
$regularization_losses
%	variables
&	keras_api
R__call__
*S&call_and_return_all_conditional_losses"
_tf_keras_layer
╗

kernel
bias
'trainable_variables
(regularization_losses
)	variables
*	keras_api
T__call__
*U&call_and_return_all_conditional_losses"
_tf_keras_layer
-:+2rank_net_20/dense_62/kernel
':%2rank_net_20/dense_62/bias
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
Г
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
Г
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
-:+2rank_net_20/dense_60/kernel
':%2rank_net_20/dense_60/bias
-:+2rank_net_20/dense_61/kernel
':%2rank_net_20/dense_61/bias
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
Г
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
Г
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
є2Ѓ
-__inference_rank_net_20_layer_call_fn_2218236
-__inference_rank_net_20_layer_call_fn_2218364б
Ў▓Ћ
FullArgSpec
argsџ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsџ 
kwonlydefaults
 
annotationsф *
 
оBМ
"__inference__wrapped_model_2218143input_1input_2"ў
Љ▓Ї
FullArgSpec
argsџ 
varargsjargs
varkwjkwargs
defaults
 

kwonlyargsџ 
kwonlydefaults
 
annotationsф *
 
╝2╣
H__inference_rank_net_20_layer_call_and_return_conditional_losses_2218405
H__inference_rank_net_20_layer_call_and_return_conditional_losses_2218322б
Ў▓Ћ
FullArgSpec
argsџ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsџ 
kwonlydefaults
 
annotationsф *
 
н2Л
*__inference_dense_62_layer_call_fn_2218414б
Ў▓Ћ
FullArgSpec
argsџ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsџ 
kwonlydefaults
 
annotationsф *
 
№2В
E__inference_dense_62_layer_call_and_return_conditional_losses_2218424б
Ў▓Ћ
FullArgSpec
argsџ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsџ 
kwonlydefaults
 
annotationsф *
 
О2н
-__inference_subtract_20_layer_call_fn_2218430б
Ў▓Ћ
FullArgSpec
argsџ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsџ 
kwonlydefaults
 
annotationsф *
 
Ы2№
H__inference_subtract_20_layer_call_and_return_conditional_losses_2218436б
Ў▓Ћ
FullArgSpec
argsџ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsџ 
kwonlydefaults
 
annotationsф *
 
МBл
%__inference_signature_wrapper_2218346input_1input_2"ћ
Ї▓Ѕ
FullArgSpec
argsџ 
varargs
 
varkwjkwargs
defaults
 

kwonlyargsџ 
kwonlydefaults
 
annotationsф *
 
н2Л
*__inference_dense_60_layer_call_fn_2218445б
Ў▓Ћ
FullArgSpec
argsџ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsџ 
kwonlydefaults
 
annotationsф *
 
№2В
E__inference_dense_60_layer_call_and_return_conditional_losses_2218456б
Ў▓Ћ
FullArgSpec
argsџ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsџ 
kwonlydefaults
 
annotationsф *
 
н2Л
*__inference_dense_61_layer_call_fn_2218465б
Ў▓Ћ
FullArgSpec
argsџ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsџ 
kwonlydefaults
 
annotationsф *
 
№2В
E__inference_dense_61_layer_call_and_return_conditional_losses_2218476б
Ў▓Ћ
FullArgSpec
argsџ
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargsџ 
kwonlydefaults
 
annotationsф *
 Й
"__inference__wrapped_model_2218143ЌXбU
NбK
IбF
!і
input_1         
!і
input_2         
ф "3ф0
.
output_1"і
output_1         Ц
E__inference_dense_60_layer_call_and_return_conditional_losses_2218456\/б,
%б"
 і
inputs         
ф "%б"
і
0         
џ }
*__inference_dense_60_layer_call_fn_2218445O/б,
%б"
 і
inputs         
ф "і         Ц
E__inference_dense_61_layer_call_and_return_conditional_losses_2218476\/б,
%б"
 і
inputs         
ф "%б"
і
0         
џ }
*__inference_dense_61_layer_call_fn_2218465O/б,
%б"
 і
inputs         
ф "і         Ц
E__inference_dense_62_layer_call_and_return_conditional_losses_2218424\/б,
%б"
 і
inputs         
ф "%б"
і
0         
џ }
*__inference_dense_62_layer_call_fn_2218414O/б,
%б"
 і
inputs         
ф "і         о
H__inference_rank_net_20_layer_call_and_return_conditional_losses_2218322ЅXбU
NбK
IбF
!і
input_1         
!і
input_2         
ф "%б"
і
0         
џ п
H__inference_rank_net_20_layer_call_and_return_conditional_losses_2218405ІZбW
PбM
KбH
"і
inputs/0         
"і
inputs/1         
ф "%б"
і
0         
џ Г
-__inference_rank_net_20_layer_call_fn_2218236|XбU
NбK
IбF
!і
input_1         
!і
input_2         
ф "і         »
-__inference_rank_net_20_layer_call_fn_2218364~ZбW
PбM
KбH
"і
inputs/0         
"і
inputs/1         
ф "і         м
%__inference_signature_wrapper_2218346еiбf
б 
_ф\
,
input_1!і
input_1         
,
input_2!і
input_2         "3ф0
.
output_1"і
output_1         л
H__inference_subtract_20_layer_call_and_return_conditional_losses_2218436ЃZбW
PбM
KџH
"і
inputs/0         
"і
inputs/1         
ф "%б"
і
0         
џ Д
-__inference_subtract_20_layer_call_fn_2218430vZбW
PбM
KџH
"і
inputs/0         
"і
inputs/1         
ф "і         