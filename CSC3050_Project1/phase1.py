import re
#get the lines in the .asm file
f =open('tem_file.txt',mode='r')
tem_content_0 = f.readlines()

#get testfile and output file from tem_file
test_output= tem_content_0[0].split(' ')
testfile = test_output[0]
outputfile = test_output[1]
ff = open(testfile,'r')
tem_content = ff.readlines()


content =[]
content_tem =[]
for lines in tem_content:
    if lines[0] != '#':
        lines1 = lines.strip('\t')
        lines2 = lines1.strip('\n')
        line = lines2.strip(' ')
        line = re.sub(' +',' ',line)
        content_tem.append(line)
ind = content_tem.index('.text') +1
content = content_tem[ind:]


#a list to store the index of label
label_index =[]
label_name =[]
label={}
#the number of labels
label_num = 0

#initial address
ini_add = int('0x00400000',16)
#list to store the address of labels
label_add=[]

ins_map={
    #R type instruction:type, function, opcode
    'add'   : ('R','100000', '0x00', 'rd','rs','rt'), 
    'addu'  : ('R','100001', '0x00', 'rd','rs','rt'), 
    'and'   : ('R','100100', '0x00', 'rd','rs','rt'), 
    'div'   : ('R','011010', '0x00', 'rs','rt','0'),
    'divu'  : ('R','011011', '0x00', 'rs','rt','0'),
    'jalr'  : ('R','001001', '0x00', 'rd','rs','0'),
    'jr'    : ('R','001000', '0x00', 'rs','0','0'),
    'mfhi'  : ('R','010000', '0x00','rd','0','0'),
    'mflo'  : ('R','010010', '0x00','rd','0','0'),
    'mthi'  : ('R','010001', '0x00','rs','0','0'),
    'mtlo'  : ('R','010011', '0x00','rs','0','0'),
    'mult'  : ('R','011000', '0x00', 'rs','rt','0'),
    'multu' : ('R','011001', '0x00', 'rs','rt','0'),
    'nor'   : ('R','100111', '0x00', 'rd','rs','rt'), 
    'or'    : ('R','100101', '0x00', 'rd','rs','rt'), 
    'sll'   : ('R','000000', '0x00', 'rd','rt','sa'), 
    'sllv'  : ('R','000100', '0x00', 'rd','rt','rs'), 
    'slt'   : ('R','101010', '0x00', 'rd','rs','rt'),
    'sltu'  : ('R','101011', '0x00', 'rd','rs','rt'),
    'sra'   : ('R','000011', '0x00', 'rd','rt','sa'),
    'srav'  : ('R','000111', '0x00', 'rd','rt','rs'),
    'srl'   : ('R','000010', '0x00', 'rd','rs','sa'),
    'srlv'  : ('R','000110', '0x00', 'rd','rt','rs'),
    'sub'   : ('R','100010', '0x00', 'rd','rs','rt'), 
    'subu'  : ('R','100011', '0x00', 'rd','rs','rt'), 
    'syscall': ('R','001100', '0x00','0','0','0'), 
    'xor'   : ('R','100110', '0x00','rd','rs','rt'), 
    #I type instruction:  type,  opcode,  rs,   rt,   immediate ,label
    'addi'   : ('I','001000','rt', 'rs', 'im'),
    'addiu'   : ('I','001001','rt', 'rs', 'im'),
    'andi'   : ('I','001100','rt', 'rs', 'im'),
    'beq'   : ('I','000100','rs', 'rt', 'la'),
    'bgez'   : ('I','000001','rs', 'lb','00001'), #rt=00001
    'bgtz'   : ('I','000111','rs', 'lb','00000'), #rt=00000
    'blez'   : ('I','000110','rs', 'lb','00000'), #rt=00000
    'bltz'   : ('I','000001','rs', 'lb','00000'), #rt=00000
    'bne'   : ('I','000101','rs', 'rt', 'la'), 
    'lb'   : ('I','100000','rt', 'im', 'rs'), 
    'lbu'   : ('I','100100','rt', 'im', 'rs'), 
    'lh'   : ('I','100001','rt', 'im', 'rs'), 
    'lhu'   : ('I','100101','rt', 'im', 'rs'), 
    'lui'   : ('I','001111','rt', 'im', '0'), 
    'lw'   : ('I','100011','rt', 'im', 'rs'), 
    'ori'   : ('I','001101','rt', 'rs', 'im'), 
    'sb'   : ('I','101000','rt', 'im', 'rs'), 
    'slti'   : ('I','001010','rt', 'rs', 'im'), 
    'sltiu'   : ('I','001011','rt', 'rs', 'im'), 
    'sh'   : ('I','101001','rt', 'im', 'rs'), 
    'sw'   : ('I','101011','rt', 'im', 'rs'), 
    'xori'   : ('I','001110','rt', 'rs', 'im'), 
    'lwl'   : ('I','100010','rt', 'im', 'rs'), 
    'lwr'   : ('I','100110','rt', 'im', 'rs'), 
    'swl'   : ('I','101010','rt', 'im', 'rs'), 
    'swr'   : ('I','101110','rt', 'im', 'rs'), 
    #J type instruction:opcode
    'j'   : ('J','000010'), 
    'jal'   : ('J','000011')
    }
all_label ={}  
#first scan
for lines in content:
    tem_line = lines.split(' ')
    if tem_line[0] not in ins_map:
        label_name.append(tem_line[0])
        label_index.append(content.index(lines) -label_num) #label的下一条instruction的地址，即label要在0x400000加4的次数;与第n条指令位置相同
        label_num += 1
        names_indic = lines.strip(':')
        all_label[names_indic]=(content.index(lines) -label_num+1)


#过滤了label的指令，可以直接用index算地址
ins_add=[]
for i in content:
    if i.strip(':') not in all_label:
        ins_add.append(i)


