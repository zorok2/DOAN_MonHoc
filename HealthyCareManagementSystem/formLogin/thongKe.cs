﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace formLogin
{
    public partial class thongKe : Form
    {
        public thongKe()
        {
            InitializeComponent();
        }

        private void thongKe_Load(object sender, EventArgs e)
        {
            DataTable dt = ClassProvider.dataProvider.Instance.GetDataTableByProcedure("TKDT_NAM");
            chart1.DataSource = dt;
            chart1.Series["DoanhThu"].XValueMember = "THANG";
            chart1.Series["DoanhThu"].YValueMembers = "DOANHTHU";
            //
            DataTable dtb = ClassProvider.dataProvider.Instance.GetDataTableByProcedure("TKSLHD");
            chart2.DataSource = dtb;
            chart2.Series["SoHoaDon"].XValueMember = "THANG";
            chart2.Series["SoHoaDon"].YValueMembers = "SOLUONGHD";
            //
            DataTable c3 = ClassProvider.dataProvider.Instance.GetDataTableByProcedure("TKDT_NAM");
            chart3.DataSource = dt;
            chart3.Series["DoanhThu"].XValueMember = "THANG";
            chart3.Series["DoanhThu"].YValueMembers = "DOANHTHU";
            DataTable doanhthudata = ClassProvider.dataProvider.Instance.GetDataTableByProcedure("doanhThuData");
            dtgvDoanhThu.DataSource = doanhthudata;
        }
        private void rjButton3_Click(object sender, EventArgs e)
        {
            chart2.ResetAutoValues();
            DataTable DSP = ClassProvider.dataProvider.Instance.GetDataTableByProcedure("TKSP");
            chart2.DataSource = DSP;
            chart2.Series["SoHoaDon"].XValueMember = "MASP";
            chart2.Series["SoHoaDon"].YValueMembers = "TONGSOLUONG";
            chart2.Titles[0].Text = "Doanh thu hóa đơn";


        }

        private void rjButton1_Click(object sender, EventArgs e)
        {
            chart2.ResetAutoValues();

            DataTable dtb = ClassProvider.dataProvider.Instance.GetDataTableByProcedure("TKSLHD");
            chart2.DataSource = dtb;
            chart2.Series["SoHoaDon"].XValueMember = "THANG";
            chart2.Series["SoHoaDon"].YValueMembers = "SOLUONGHD";
            chart2.Titles[0].Text = "Doanh thu sản phẩm";

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }
    }
}
