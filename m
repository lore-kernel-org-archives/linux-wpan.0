Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:36393 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbbEaMeg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 31 May 2015 08:34:36 -0400
Received: by wgbgq6 with SMTP id gq6so94445405wgb.3
        for <linux-wpan@vger.kernel.org>; Sun, 31 May 2015 05:34:35 -0700 (PDT)
Date: Sun, 31 May 2015 14:34:31 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: At86rf212B(driver at86rf230), Ralink MT7228, cs1 always high
Message-ID: <20150531123430.GC1476@omega>
References: <CAPpUg6Pa7xOOScRSf5qvBEJqEdBp_=e5J_Ozbmd10CgbnCgjcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPpUg6Pa7xOOScRSf5qvBEJqEdBp_=e5J_Ozbmd10CgbnCgjcA@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Baptiste Clenet <bapclenet@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Fri, May 29, 2015 at 11:28:48AM +0200, Baptiste Clenet wrote:
> Hi,
> 
> I'm working on the board Ralink MT7228 with an Atmel AT86RF212B by SPI.
> I've configured the transceiver to be on cs1. I plugged cs from the
> transceiver to pin 6 of MT7228.
> I've edited spi-mt7621.c to allow two slave on SPI master as follow:
> 

sorry, I have no idea what you mean and did there. To make the
chipselect right I suppose this part of spi subsystem, you don't need
(if you don't doing hacks) to touch anything at driver layer. What you
need is to tell the spi subsystem the right configuration so the spi
controller can do the right thing.

I also tried to google "Ralink MT7228" without luck.

Do you boot via device tree or the old way?

- Alex
