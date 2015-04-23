Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:35979 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032AbbDWJhr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Apr 2015 05:37:47 -0400
Received: by wgen6 with SMTP id n6so12096787wge.3
        for <linux-wpan@vger.kernel.org>; Thu, 23 Apr 2015 02:37:46 -0700 (PDT)
Date: Thu, 23 Apr 2015 11:37:40 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: at86rf233 on BeagleBone Black
Message-ID: <20150423093739.GA8178@omega>
References: <551EDFCA.3070905@fid4.com>
 <20150403191320.GD773@omega>
 <20150414150656.GB2179@omega>
 <553024C3.2020207@fid4.com>
 <55307D66.7020606@gmail.com>
 <55310A85.5080601@fid4.com>
 <20150417221913.GA3338@omega>
 <55353FC0.5050909@fid4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55353FC0.5050909@fid4.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Michael C. Cambria" <mcc@fid4.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

On Mon, Apr 20, 2015 at 02:04:48PM -0400, Michael C. Cambria wrote:
...
> 
> &spi1 {
>         status = "okay";
>         pinctrl-names = "default";
>         pinctrl-0 = <&spi1_pins>;
>         at86rf233@0 {
>                 compatible = "atmel,at86rf233";
>                 spi-max-frequency = <500000>;

now I detect this here. Why such low clock? You should use a 7.5 Mhz
clock here not 500 Khz. I had some troubles with such a low clock and
fragmentation handling.

Means:

change it to "spi-max-frequency = <7500000>;"

- Alex
