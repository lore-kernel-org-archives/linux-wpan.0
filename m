Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:39337 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbbAVH7Z (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 22 Jan 2015 02:59:25 -0500
Received: by mail-we0-f170.google.com with SMTP id x3so200115wes.1
        for <linux-wpan@vger.kernel.org>; Wed, 21 Jan 2015 23:59:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150121154634.GA664@omega>
References: <CAAkG1NOO3ScSHG7x+LgU6Min8OP-vcihwXwmLH7JSzGeVw8tyQ@mail.gmail.com>
	<20150120194407.GB18226@omega>
	<CAAkG1NNuA0vp1A6brVbHw0Co1qL5rAVCPBT=+t+cBZULveBhiw@mail.gmail.com>
	<CAFUtXGw2_+6CCX69RKxv0BueCx5mhddBt3k7yDXzoHcF-r9+Pw@mail.gmail.com>
	<54bf9983.07f4440a.7103.0a2e@mx.google.com>
	<20150121154634.GA664@omega>
Date: Thu, 22 Jan 2015 13:29:24 +0530
Message-ID: <CAAkG1NNNTLaH0TgEupLm3yVEU6wwXPBR38mpMrPfb-bu7wUAPg@mail.gmail.com>
Subject: Re: Device or resource busy
From: Rohit Kulkarni <rmkulkar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Maciej Wasilak <wasilak@gmail.com>, linux-wpan@vger.kernel.org

Hi,

ifdown/ifup also doesn't work on loopback and eth0! So this looks like
a larger issue. Any ideas where I can get help for this?

-Rohit

On Wed, Jan 21, 2015 at 9:16 PM, Alexander Aring <alex.aring@gmail.com> wrote:
> Hi,
>
> On Wed, Jan 21, 2015 at 05:48:36PM +0530, Rohit Kulkarni wrote:
>> Hi all,
>>
>> I'm now on bluetooth-next and still seeing the problem. So, definitely doesn't look like a raspbian issue.
>>
>
> Can you please check if an ifdown/ifup of your loopback interface works?
> Usually name of the interface is "lo". If this works, then we know
> it's a 802.15.4 specfic issue and we can do more detailed debugging
> steps.
>
> Thanks.
>
> - Alex
