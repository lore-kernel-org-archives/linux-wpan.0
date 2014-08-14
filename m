Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:56963 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbaHNINv (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 14 Aug 2014 04:13:51 -0400
Received: by mail-we0-f181.google.com with SMTP id k48so728139wev.26
        for <linux-wpan@vger.kernel.org>; Thu, 14 Aug 2014 01:13:50 -0700 (PDT)
Date: Thu, 14 Aug 2014 10:13:48 +0200
From: Alexander Aring <alex.aring@gmail.com>
Message-ID: <20140814081347.GB19177@omega>
References: <1407849255-11500-1-git-send-email-alex.aring@gmail.com>
 <53EC6734.6050503@xsilon.com>
 <20140814075900.GA19177@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140814075900.GA19177@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: Re: [PATCH wpan-next 00/11] ieee802154: mac802154: wireless
 transformation
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Aug 14, 2014 at 09:59:00AM +0200, Alexander Aring wrote:
> And really I don't want to insert something mainline which breaks any
> existing support (monitor, fakelb, crypto, ...). I can't do a deletion of
> net/mac802154 (ieee802154) and simple add a new one, but deleting of
> subsubsystems like montior, fakelb and add a rework of this should not
> make any problems.
> 

okay, that's maybe not correct I want to drop the channel setting
feature while xmit which "could" be use for channel hoping On
multiple interfaces.

The reason are more... this is a sync callback and I can't deal with a
async xmit with that. Okay I can solve this to make the channel setting
async but... if somebody want channel hoping then the logic for that
should be in userspace. We don't have any kernelspace implementation of
any protocol which use the channel hoping feature.

btw. the wireless implementation forbids multiple interface with
different channels. [0]

[0] is a neat introduction how wireless userspace access works. Page
21/35 "only matching PHY parameters possible e.g. all virtual interfaces
are on one channel".

[0] http://wireless.kernel.org/en/developers/Documentation/cfg80211?action=AttachFile&do=view&target=control.pdf

- Alex
