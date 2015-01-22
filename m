Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:65520 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754919AbbAVU73 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 22 Jan 2015 15:59:29 -0500
Received: by mail-we0-f173.google.com with SMTP id w62so4097422wes.4
        for <linux-wpan@vger.kernel.org>; Thu, 22 Jan 2015 12:59:28 -0800 (PST)
Date: Thu, 22 Jan 2015 21:59:22 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Device or resource busy
Message-ID: <20150122205920.GA18612@omega>
References: <CAAkG1NOO3ScSHG7x+LgU6Min8OP-vcihwXwmLH7JSzGeVw8tyQ@mail.gmail.com>
 <20150120194407.GB18226@omega>
 <CAAkG1NNuA0vp1A6brVbHw0Co1qL5rAVCPBT=+t+cBZULveBhiw@mail.gmail.com>
 <CAFUtXGw2_+6CCX69RKxv0BueCx5mhddBt3k7yDXzoHcF-r9+Pw@mail.gmail.com>
 <54bf9983.07f4440a.7103.0a2e@mx.google.com>
 <20150121154634.GA664@omega>
 <CAAkG1NNNTLaH0TgEupLm3yVEU6wwXPBR38mpMrPfb-bu7wUAPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAkG1NNNTLaH0TgEupLm3yVEU6wwXPBR38mpMrPfb-bu7wUAPg@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Rohit Kulkarni <rmkulkar@gmail.com>
Cc: Maciej Wasilak <wasilak@gmail.com>, linux-wpan@vger.kernel.org

Hi,

On Thu, Jan 22, 2015 at 01:29:24PM +0530, Rohit Kulkarni wrote:
> Hi,
> 
> ifdown/ifup also doesn't work on loopback and eth0! So this looks like
> a larger issue. Any ideas where I can get help for this?
> 

can you please send the output of:

`strace -f ifconfig wpan0 down`

Additional please give more information about your ifconfig version, is
it a busybox one? Ff yes then please tell us the busybox version.

Then maybe I can help you, otherwise maybe netdev or raspbian forums?

Thanks.

- Alex
