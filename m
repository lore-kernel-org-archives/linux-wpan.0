Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:35970 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932708AbbDIOQl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 9 Apr 2015 10:16:41 -0400
Received: by wgsk9 with SMTP id k9so99237807wgs.3
        for <linux-wpan@vger.kernel.org>; Thu, 09 Apr 2015 07:16:40 -0700 (PDT)
Date: Thu, 9 Apr 2015 16:16:34 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: AT86RF230 driver
Message-ID: <20150409141630.GA8150@omega>
References: <000001d072be$e474ffd0$ad5eff70$@xsoen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000001d072be$e474ffd0$ad5eff70$@xsoen.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Maxence Chotard <maxence.chotard@xsoen.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On Thu, Apr 09, 2015 at 02:15:37PM +0200, Maxence Chotard wrote:
> Hello,
> 
>  
> 
> I am a student in my last year of engineering school and for the purpose of
> an embedded project, I am trying to use an At86rf212b transceiver on a
> Raspberry Pi with OpenWrt as OS. I am actually facing difficulties to
> understand how to use the driver you wrote for at86rf230 and I would like to
> know if you can explain me how to use it. Should I call at86rf230_probe
> function to initialize the transceiver ?
> 

There is some recent setup tutorial at [0].
Also you should register yourself at [1], there are a lot of people
which use the at86rf230 driver on a RPi. Feel free to ask questions there.

- Alex

[0] https://honk.sigxcpu.org/piki/hw/rpi6lowpan/
[1] http://vger.kernel.org/vger-lists.html#linux-wpan
