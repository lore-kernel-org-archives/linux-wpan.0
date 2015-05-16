Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35733 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbbEPPdk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 16 May 2015 11:33:40 -0400
Received: by wicmx19 with SMTP id mx19so26547601wic.0
        for <linux-wpan@vger.kernel.org>; Sat, 16 May 2015 08:33:38 -0700 (PDT)
Date: Sat, 16 May 2015 17:33:33 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Kernel crash when using multiple interfaces
Message-ID: <20150516153329.GA31491@omega>
References: <5555EC72.6060302@xsilon.com>
 <20150515142026.GA11157@omega>
 <55560A88.1050903@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55560A88.1050903@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org

Hi Simon,

On Fri, May 15, 2015 at 04:02:32PM +0100, Simon Vincent wrote:
> I tried the solution you proposed but it did not work, it resulted in a
> kernel crash (bad paging request).
> 

I can now reproduce your issue when I am using the fakelb driver _with_
xmit_sync callback and two vitual phys.

I tried my patch and it's working fine afterwards, can you please check
if the "kernel crash (bad paging request)" isn't another issue or
something failed while applying the diff?

Can you check that again? This issue should be fixed into bluetooth, very
ugly bug.

- Alex
