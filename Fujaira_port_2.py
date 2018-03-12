import numpy as np
import pandas as pd

# Module Convert eta,etb and etd column into standard datetime format of R language

class Fujaira:

    def form_date_string_vector(self,column_vector):

        temp_list = list()

        # for each item in eta_vector split into date & time, form into standard format of datetime string & put into eta_list list
        for data in column_vector:
            date_split_list = data.split()
            # access date string
            str_date = date_split_list[0]
            # access time string
            str_time = date_split_list[1]

            # split str_date string to access day and month
            str_date_list = str_date.split('/')
            # access day from str_date_list
            str_day = str_date_list[0]
            # access month from str_date_list
            str_month = str_date_list[1]

            # we have date but no year specified thats why we specified year( we have data of dec17,jan18 and feb18)
            if str_month == '12':
                str_year = '2017'
            else:
                str_year = '2018'

            # form date string
            str_new_date = str_year + '-' + str_month + '-' + str_day

            # access hour string
            str_hour = str_time[0:2]
            # access minute string
            str_minute = str_time[2:4]

            str_second = '00'

            str_new_time = str_hour + ':' + str_minute + ':' + str_second

            # forming new datetime string
            str_new_datetime = str_new_date + ' ' + str_new_time + " IST"
            # print(str_new_datetime)
            temp_list.append(str_new_datetime)

        return temp_list

if  __name__ == "__main__":

    # reading fujaira dataset into fdata  data.frame
    fdata = pd.read_csv('E:\Fujaira port analysis\Fujaira_unique.csv')

    # view forst five rows
    print(fdata.head())

    # access eta column from fdata frame
    eta_vector = fdata['eta']

    # access etb column from fdata frame
    etb_vector = fdata['etb']

    # access etd column from fdata frame
    etd_vector = fdata['etd']

    # create object of Fujaira class
    fuj_object = Fujaira()

    # form structured date time string for eta,etb and etd column
    eta_list = fuj_object.form_date_string_vector(eta_vector)
    etb_list = fuj_object.form_date_string_vector(etb_vector)
    etd_list = fuj_object.form_date_string_vector(etd_vector)

    # form new data frame with new datetime column
    list_vessel = list(fdata['vessel'])
    list_qty = list(fdata['qty'])
    list_shipper = list(fdata['shipper'])
    list_berth = list(fdata['berth'])
    dict_fdata = {'vessel': list_vessel, 'berth': list_berth, 'eta': eta_list, 'etb': etb_list, 'etd': etd_list,
                  'qty': list_qty,
                  'shipper': list_shipper, }
    new_fdata = pd.DataFrame(dict_fdata)
    print(new_fdata)

    # write into Fujaira_structured.csv file
    new_fdata.to_csv('E:\Fujaira port analysis\Fujaira_structured.csv', index=False)
