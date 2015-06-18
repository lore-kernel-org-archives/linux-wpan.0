Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:61384 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754439AbbFRKMX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Jun 2015 06:12:23 -0400
Message-ID: <55829983.3080608@xsilon.com>
Date: Thu, 18 Jun 2015 11:12:19 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: 802.15.4 security
References: <555DDC3E.6090203@xsilon.com> <20150528110026.70a44e0d@zoidberg>
In-Reply-To: <20150528110026.70a44e0d@zoidberg>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hi Phoebe,

I am having some problems with the 802.15.4 security.

What kernel version/gitref did you last test the 802.15.4 security on?
What level of security are you using? (1-7)

I can then have a look what has changed since and try and debug the 
problems I am seeing.

I find if I set the security level to 1,2,3 I get a kernel panic 
whenever a packet is sent.
If I set the security level to 4 the packets sent are corrupt.
If I set the security level to 5-7 wireshark decodes the packets as MIC 
check failed.

Regards

Simon

On 28/05/15 10:00, Phoebe Buckheister wrote:
> Hi Simon,
>
> sorry for taking so long to reply. Unfortunately, there's currently no
> actual documentation for the crypto layer (and I probably won't come
> around to write any sometime soon), but I have built an application
> that works with llsec [1].
>
> The process to set up a crypto config for a network is rougly outlined
> in [2] and [3]. There are more options to the crypto layer than are used
> there, but the process is pretty much the same: you add a number of
> devices you want to securely communicate with, add the keys those
> devices will use to communicate, and then set the general parameters
> for llsec (like default llsec, enabling the crypto layer and such).
>
> Hope that helps a little,
> Phoebe
>
>
> [1]
> https://github.com/mysmartgrid/hexabus/blob/pb-crypto/hostsoftware/hxbnm
> [2]
> https://github.com/mysmartgrid/hexabus/blob/pb-crypto/hostsoftware/hxbnm/src/hxbnm.cpp#L160
> [3]
> https://github.com/mysmartgrid/hexabus/blob/pb-crypto/hostsoftware/hxbnm/src/hxbnm.cpp#L90
>
> On Thu, 21 May 2015 14:23:10 +0100
> Simon Vincent <simon.vincent@xsilon.com> wrote:
>
>> What is the status of the crypto-layer? I can see a lot of crypto
>> functionality in the mac layer but I can't work out how to setup the
>> keys and enable encryption/authentication. Will this be part of the
>> wpan-tools?
>>
>> - Simon
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-wpan"
>> in the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

