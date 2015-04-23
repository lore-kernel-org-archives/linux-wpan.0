Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35702 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758175AbbDWO76 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Apr 2015 10:59:58 -0400
Received: by widdi4 with SMTP id di4so219173819wid.0
        for <linux-wpan@vger.kernel.org>; Thu, 23 Apr 2015 07:59:56 -0700 (PDT)
Date: Thu, 23 Apr 2015 16:59:53 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: at86rf233 on BeagleBone Black
Message-ID: <20150423145952.GD9284@omega>
References: <551EDFCA.3070905@fid4.com>
 <20150403191320.GD773@omega>
 <20150414150656.GB2179@omega>
 <553024C3.2020207@fid4.com>
 <55307D66.7020606@gmail.com>
 <55310A85.5080601@fid4.com>
 <20150417221913.GA3338@omega>
 <55353FC0.5050909@fid4.com>
 <20150423093739.GA8178@omega>
 <5538F7E7.9020308@fid4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5538F7E7.9020308@fid4.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Michael C. Cambria" <mcc@fid4.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

On Thu, Apr 23, 2015 at 09:47:19AM -0400, Michael C. Cambria wrote:
> 
> 
> On 04/23/2015 05:37 AM, Alexander Aring wrote:
> >On Mon, Apr 20, 2015 at 02:04:48PM -0400, Michael C. Cambria wrote:
> >....
> >>&spi1 {
> >>         status = "okay";
> >>         pinctrl-names = "default";
> >>         pinctrl-0 = <&spi1_pins>;
> >>         at86rf233@0 {
> >>                 compatible = "atmel,at86rf233";
> >>                 spi-max-frequency = <500000>;
> >now I detect this here. Why such low clock? You should use a 7.5 Mhz
> >clock here not 500 Khz. I had some troubles with such a low clock and
> >fragmentation handling.
> >
> >Means:
> >
> >change it to "spi-max-frequency = <7500000>;"
> >
> >- Alex
> 
> The openlabs blog post [0] used 500 Khz:

I know and that's terrible...

This was tested when the driver was in a "bad" state.

- Alex
