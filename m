Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:41496 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbbAUL6j (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 21 Jan 2015 06:58:39 -0500
Received: by mail-wi0-f172.google.com with SMTP id bs8so35500443wib.5
        for <linux-wpan@vger.kernel.org>; Wed, 21 Jan 2015 03:58:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAAkG1NNuA0vp1A6brVbHw0Co1qL5rAVCPBT=+t+cBZULveBhiw@mail.gmail.com>
References: <CAAkG1NOO3ScSHG7x+LgU6Min8OP-vcihwXwmLH7JSzGeVw8tyQ@mail.gmail.com>
	<20150120194407.GB18226@omega>
	<CAAkG1NNuA0vp1A6brVbHw0Co1qL5rAVCPBT=+t+cBZULveBhiw@mail.gmail.com>
Date: Wed, 21 Jan 2015 12:58:38 +0100
Message-ID: <CAFUtXGw2_+6CCX69RKxv0BueCx5mhddBt3k7yDXzoHcF-r9+Pw@mail.gmail.com>
Subject: Re: Device or resource busy
From: Maciej Wasilak <wasilak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Rohit Kulkarni <rmkulkar@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hello

2015-01-21 11:30 GMT+01:00 Rohit Kulkarni <rmkulkar@gmail.com>:
> I tried the "ip link set" command but the wpan interface doesn't go
> down. The wpan1 device is already UP on boot and setting the channel
> works fine but it fails with -EBUSY when trying to set pan_id.

I wrote the previous email about that problem. I experienced same
issues as Rohit. It seems that problem doesn't occur on all platforms.
Two related questions:

1. Is it possible that this issue is somehow related to distro (we
both use Raspbian)?
2. Is it possible that this issue is caused by improper device tree
information? Maybe something changed in device tree handling in last 3
months?

Best Regards
Maciek
