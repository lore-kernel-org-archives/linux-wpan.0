Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:52637 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932153AbbERK5W (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 18 May 2015 06:57:22 -0400
Message-ID: <5559C58F.6010607@xsilon.com>
Date: Mon, 18 May 2015 11:57:19 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: Kernel crash when using multiple interfaces
References: <5555EC72.6060302@xsilon.com> <20150515142026.GA11157@omega> <55560A88.1050903@xsilon.com> <20150516153329.GA31491@omega>
In-Reply-To: <20150516153329.GA31491@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi Alex,

I can confirm your patch still results in the bad paging request.
Maybe you are not seeing it as you have a slightly different setup.

If I understand correctly you have two virtual phys going to a single 
wpan interface
e.g.
phy0 -> wpan0
phy1 -> wpan0

My setup is two separate transceivers. Each with its own phy and wpan 
interface.
e.g.
phy0 -> wpan0
phy1 -> wpan1

- Simon

On 16/05/15 16:33, Alexander Aring wrote:
> Hi Simon,
>
> On Fri, May 15, 2015 at 04:02:32PM +0100, Simon Vincent wrote:
>> I tried the solution you proposed but it did not work, it resulted in a
>> kernel crash (bad paging request).
>>
> I can now reproduce your issue when I am using the fakelb driver _with_
> xmit_sync callback and two vitual phys.
>
> I tried my patch and it's working fine afterwards, can you please check
> if the "kernel crash (bad paging request)" isn't another issue or
> something failed while applying the diff?
>
> Can you check that again? This issue should be fixed into bluetooth, very
> ugly bug.
>
> - Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

