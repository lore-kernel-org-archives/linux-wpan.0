Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:33089 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbaKDMhZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 4 Nov 2014 07:37:25 -0500
Received: by mail-la0-f51.google.com with SMTP id q1so771573lam.24
        for <linux-wpan@vger.kernel.org>; Tue, 04 Nov 2014 04:37:23 -0800 (PST)
Date: Tue, 4 Nov 2014 13:37:20 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: problems with udp header compression
Message-ID: <20141104123718.GB643@omega>
References: <5452081F.5090706@xsilon.com>
 <5452107B.8010805@xsilon.com>
 <20141101091052.GB31204@omega>
 <5458C7DB.5060706@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5458C7DB.5060706@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org

On Tue, Nov 04, 2014 at 12:34:35PM +0000, Simon Vincent wrote:
> I will send a patch. I have done lots of testing and it seems fine.
> Do you want the patch based on bluetooth-next?
> 
yes, please eveything on bluetooth-next now.

Please cc:

linux-wpan@vger.kernel.org

and

linux-bluetooth@vger.kernel.org 

this problem should also occur on bluetooth 6LoWPAN.
I think it's some patch for "net/6lowpan/iphc.c".

- Alex
