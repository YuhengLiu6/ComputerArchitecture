import phase1 as p1

#a list to store the machine code
machine_code =[]

reg ={
    '$zero': '0', '$at': '1', '$v0': '2', '$v1': '3', '$a0': '4',
    '$a1': '5', '$a2': '6', '$a3': '7', '$t0': '8', '$t1': '9',
    '$t2': '10', '$t3': '11', '$t4': '12', '$t5': '13', '$t6': '14',
    '$t7': '15', '$s0': '16', '$s1': '17', '$s2': '18', '$s3': '19',
    '$s4': '20', '$s5': '21', '$s6': '22', '$s7': '23', '$t8': '24',
    '$t9': '25', '$k0': '26', '$k1': '27', '$gp': '28', '$sp': '29',
    '$fp': '30', '$ra': '31'
}

def get_twosComplement(m):
    Mid_list=[]
    for i in m:
        if i =='1':
            Mid_list.append('0')
        else:
            Mid_list.append('1')
    if len(Mid_list) < 16:
        df = 16-len(Mid_list)
        Mid_list.insert(0,'1'*df)
    comp = ''.join(Mid_list)
    ans = bin(int(comp,2)+1)[2:]
    return ans


#second scan
for lines in p1.content:
    tem_line = lines.split(' ')
    tem_line1 = lines.replace(')',' ')
    tem_line2 = tem_line1.replace('(',' ').split(' ')
    #tem_line[0] is a instruction name like 'addi'
    if tem_line[0] in p1.ins_map:
        #ins is the tupple of one specific instruction
        ins = p1.ins_map[tem_line[0]]
        #the first element in each tupple, ie the instruction type
        if ins[0] == 'R':
            if ins[3] == 'rd':
                mid_rd = tem_line[1].strip(',')
                rd = bin(int(reg[mid_rd]))[2:]
            elif ins[3] == 'rs':
                mid_rs = tem_line[1].strip(',')
                rs = bin(int(reg[mid_rs]))[2:]
            else:
                pass

            if ins[4] == 'rs':
                mid_rs = tem_line[2].strip(',')
                rs = bin(int(reg[mid_rs]))[2:]
            elif ins[4] == 'rt':
                mid_rt = tem_line[2].strip(',')
                rt = bin(int(reg[mid_rt]))[2:]
            else:
                pass

            if ins[5] == 'rs':
                mid_rs = tem_line[3].strip(',')
                rs = bin(int(reg[mid_rs]))[2:]
            elif ins[5] == 'rt':
                mid_rt = tem_line[3].strip(',')
                rt = bin(int(reg[mid_rt]))[2:]
            elif ins[5] == 'sa':
                sa = bin(int(tem_line[3]))[2:]
            else:
                pass
            fc = ins[1]
            
            if 'rs' not in ins:
                rs = '00000'
            if 'rt' not in ins:
                rt = '00000'
            if 'rd' not in ins:
                rd = '00000'
            if 'sa' not in ins:
                sa = '00000'
            

            ins_list =['000000',rs, rt, rd, sa, fc]
            for i in range(1,5):
                df = (5 - len(ins_list[i]))
                modi =[i for i in ins_list[i]]
                modi.insert(0,'0'*df)
                ins_list[i] = ''.join(modi)

            machine_code.append(''.join(ins_list))
       
       
        #to deal with I type
        elif ins[0] == 'I':
            if ins[2] == 'rt':
                mid_rt = tem_line2[1].strip(',')
                rt = bin(int(reg[mid_rt]))[2:]
            else:
                mid_rs = tem_line2[1].strip(',')
                rs = bin(int(reg[mid_rs]))[2:]

            if ins[3] == 'rt':
                mid_rt = tem_line2[2].strip(',')
                rt = bin(int(reg[mid_rt]))[2:]
            elif ins[3] == 'rs':
                mid_rs = tem_line2[2].strip(',')
                rs = bin(int(reg[mid_rs]))[2:]
            elif ins[3] == 'im':
                mid_im = []
                for i in tem_line2[2]:
                    if i.isdigit() or i =='-':
                        mid_im.append(i)
                im_decimal = ''.join(mid_im)
                if int(im_decimal) >=0:
                    im_1 =[i for i in bin(int(im_decimal))[2:]]
                    if len(im_1) <= 16:
                        df = 16-len(im_1)
                        im_1.insert(0,'0'*df)
                    im = ''.join(im_1)
                else:
                    im_2 = bin(abs(int(im_decimal)))[2:]
                    im = get_twosComplement(im_2)

            else: #ins[3]==la, label
                next_add = p1.ins_add.index(lines) +1
                label_add = p1.all_label[tem_line[2]]
                mid_im = label_add - next_add
                print (mid_im)
                if int(mid_im) >= 0:
                    im_1=  bin(int(mid_im))[2:]
                    df = 16 -len(im_1)
                    im_list = [i for i in im_1]
                    im_list.insert(0, '0'*df)
                    im = ''.join(im_list)
                else:
                    posi_im = bin(int(abs(mid_im)))[2:]
                    im = get_twosComplement(posi_im)
                p1.ins_add[p1.ins_add.index(lines)] ='used'

            if ins[4] == 'rs':
                mid_rs = tem_line2[3].strip(',')
                rs = bin(int(reg[mid_rs]))[2:]
            elif ins[4] == 'im':
                if int(tem_line2[3]) >= 0:
                    mid_im = [i for i in bin(int(tem_line2[3]))[2:]]
                    if len(mid_im) <= 16:
                        df = 16 - len(mid_im)
                        mid_im.insert(0,'0'*df)
                        im = ''.join(mid_im)
                else:
                    print(abs(int(tem_line2[3])))
                    im = get_twosComplement(bin(abs(int(tem_line2[3])))[2:])
            elif ins[4] == 'la':
                next_add = p1.ins_add.index(lines)+1
                label_add = p1.all_label[tem_line2[3]]
                mid_im =  label_add - next_add
                if mid_im >= 0:
                    im_less =[i for i in bin(int(mid_im))[2:]]
                    df =16 -len(im_less)
                    im_less.insert(0,'0'*df)
                    im = ''.join(im_less)

                else:
                    posi_im = bin(int(abs(mid_im)))[2:]
                    im = get_twosComplement(posi_im)
            elif ins[4] == '00001':
                rt = '00001'
            elif ins[4] == '00000':
                rt = '00000'
            else:
                pass
                
            op = ins[1]

            if 'rs' not in ins:
                rs = '00000'
            if 'rt' not in ins:
                rt = '00000'
            if 'im' not in ins:
                rd = '0000000000000000'
          

            ins_list =[op, rs, rt, im]
            for i in range(1,3):
                df = (5 - len(ins_list[i]))
                modi =[i for i in ins_list[i]]
                modi.insert(0,'0'*df)
                ins_list[i] = ''.join(modi)

            machine_code.append(''.join(ins_list))

        else:
            op = ins[1]
            mid_im = p1.all_label[tem_line[1]]
            abs_add = p1.ini_add + mid_im*4
            bin_form_orign = bin(abs_add)[2:]
            tem_list = [i for i in bin_form_orign]
            if len(tem_list) <= 32:
                df = 32 -len(tem_list)
                tem_list.insert(0,'0'*df)
            bin_form_32 = ''.join(tem_list)
            bin_form_26 = bin_form_32[4:30]

            ins_list =[op, bin_form_26]
            machine_code.append(''.join(ins_list))




f = open(p1.outputfile, 'w')
for i in machine_code:
    f.write(i+'\n')
f.close()

# print(machine_code)

#tem_line 是'lw $s0, 4($sp)'被空格分开后的list
# ins_map[tem_line[0]]是ins_map['add'],访问字典里存的add的信息tupple，也就是ins
#            




