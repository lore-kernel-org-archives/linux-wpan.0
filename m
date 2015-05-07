Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:64745 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbbEGS0S (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 7 May 2015 14:26:18 -0400
Message-ID: <554BAE46.4030806@xsilon.com>
Date: Thu, 07 May 2015 19:26:14 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: Oops with latest bluetooth-next kernel.
References: <554B414B.50408@xsilon.com> <20150507122441.GA17485@omega> <554B8456.9090107@xsilon.com> <20150507170052.GA714@omega>
In-Reply-To: <20150507170052.GA714@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi Alex,

On 07/05/15 18:00, Alexander Aring wrote:
> Hi,
>
> On Thu, May 07, 2015 at 04:27:18PM +0100, Martin Townsend wrote:
>> Thanks for your reply Alex,  after a bit of debugging I've tracked it down to our RPL application.  If I disable this at startup there are no lock ups.  As soon as I start the daemon it brings the Kernel down so I need to investigate why this happens.
>>
>> I'll have a go at updating the fakelb as it's useful for RPL and MPL.
>>
> ok.
>
> I also note on your outputs that the MIB defaults different what we have
> currently.
>
>          Interface wpan2
>                  ifindex 12
>                  wpan_dev 0x200000002
>                  extended_addr 0x1013749720940844
>                  short_addr 0xffff
>                  pan_id 0xffff
>                  type node
>                  max_frame_retries 4
> hehe, our mib default is -1 (no aret/csma-ca).
>                  min_be 4
> also here.
>                  max_be 9
> here as well.
>                  max_csma_backoffs 8
> we have 4 here.
>                  lbt 0
>
>
> Did you change that inside the kernel, so you have some patches on top
> of bluetooth-next?
Not that I know of, all of our patches apart from setting the tx queue 
to 50 have been pushed into bluetooth-next.  But I will check tomorrow 
to see why this is :)
Out of interest has there been much change in raw sockets since 
3.16/3.17 as this is where the RPL code could be tripping up.
> - Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
- Martin
