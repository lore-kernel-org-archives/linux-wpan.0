Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:55970 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753307AbbHDQ3C (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 4 Aug 2015 12:29:02 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [RFCv3 bluetooth-next 0/6] ieee802154: aret handling changes
References: <1438246542-17633-1-git-send-email-alex.aring@gmail.com>
Message-ID: <55C0E848.3090501@osg.samsung.com>
Date: Tue, 4 Aug 2015 18:28:56 +0200
MIME-Version: 1.0
In-Reply-To: <1438246542-17633-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 30/07/15 10:55, Alexander Aring wrote:
> Hi,
>
> this patch series contains a RFC for changing the max_frame_retries behaviour.
> The current behaviour is that we allow a range from -1 until 7 (802.15.4
> standard describes a range from 0 until 7 only). Nevertheless for historical
> reason we have the "-1" value, which describes no aret handling.
>
> The point is when the ack request bit is set inside the mac header the
> transceiver need to handle the ack somehow, this is mostly the aret mode
> which is done by hardware. Instead to having this as mac setting which doesn't
> allow a change during interface up, we simple do this handling per frame
> indicated by the ack request bit.

I think it is sound to handle it per frame to give us the opportunity to 
change this setting without taking the interface down. I wonder about 
the frame retry counter which needs to be written in some transceiver 
register to be used by the hardware directly. That one can only be done 
when the interface is down. Whcih means we can decide if we want ARET 
handling per frame but not how often the retry happens. Do I miss something?

> Instead of max_frame_retries "-1" value which could be useful for making a
> default ack request bit handling if no information is given if it should be
> set or not, we have now the ack request default entry inside the mib.
>
> This could be useful for the 6LoWPAN stack which have this as default
> behaviour for data frames.

You have the wpan-tools bits for the new netlink command pushed 
somewhere to test out with this patchset?

I'm going to review the implementation now and run some tests with this 
code enabled.

regards
Stefan Schmidt
