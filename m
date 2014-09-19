Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:62604 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbaISJeF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Sep 2014 05:34:05 -0400
Message-ID: <541BF7F4.4020508@gmail.com>
Date: Fri, 19 Sep 2014 15:01:32 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next v2 0/3] cleanup for mrf24j40 driver
References: <1411101911-12462-1-git-send-email-varkab@cdac.in> <20140919090611.GA17051@omega>
In-Reply-To: <20140919090611.GA17051@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, alan@signal11.us, Varka Bhadram <varkab@cdac.in>

Hi Alex,

On 09/19/2014 02:36 PM, Alexander Aring wrote:
> Hi Varka,
>
> nice to read you again. :-) I already thought that I was maybe a little
> bit too harsh to you for explaining changing dev->add_len during runtime
> will occur in unexcept behaviour. Sorry.

For dev->addr_len, i think David asked a question.. Isn't it..?

We need to find a way to add this. Based on this only RFC6775 is going 
to work.

But i implemented RFC6775 it works for Extended addresses only. I used 
the system
witch use extended address.

> Nevertheless welcome back. I want to apply it when Alan finally sends a
> "Acked-by: ...", but why is this tagged with bluetooth-next?

I am also waiting for Alan "Acked-by:..."  :-)

> There are other mrf24j40 patches around and it's better to send this in
> a whole patch series when all patches are on wpan-next/testing. Then I
> will send these patches to bluetooth-next. When applied I will rebase
> the wpan-next/master to bluetooth-next/master.

Ok. I got your point. Thanks... I will respin this series with wpan-next 
tag...

> Only 6LOWPAN GENERIC patches should be send to bluetooth-next.

Ok.

We are having multiple branches on wpan-next tree.
I want to know which branch is for what,..?

wpan-next/alex/wip
wpan-next/for-martin
wpan-next/for-michael
wpan-next/master
wpan-next/nhc_layer
wpan-next/tcheneau
wpan-next/testing
wpan-next/wpan_rework_rfc

-- 
Thanks and Regards,
Varka Bhadram.

