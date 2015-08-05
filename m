Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38487 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbbHEJOQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 5 Aug 2015 05:14:16 -0400
Received: by wibxm9 with SMTP id xm9so57351735wib.1
        for <linux-wpan@vger.kernel.org>; Wed, 05 Aug 2015 02:14:15 -0700 (PDT)
Date: Wed, 5 Aug 2015 11:14:41 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFCv3 bluetooth-next 4/6] mac802154: change max_frame_retries
 behaviour
Message-ID: <20150805091427.GA1386@omega>
References: <1438246542-17633-1-git-send-email-alex.aring@gmail.com>
 <1438246542-17633-5-git-send-email-alex.aring@gmail.com>
 <55C0EB0E.2010005@osg.samsung.com>
 <20150804180009.GB22216@omega>
 <55C1CD4C.1070403@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55C1CD4C.1070403@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Wed, Aug 05, 2015 at 10:46:04AM +0200, Stefan Schmidt wrote:
...
> >>This confuses me. During alloc_hw we set min to 0 which makes sense for me
> >>but afterwards we set both, min and max, to 3? Should it not only be max to
> >>three here? Am I missing something?
> >>
> >Here is also meant the range. But in this case the transceiver doesn't
> >support IEEE802154_HW_FRAME_RETRIES. Then the stack assumes the 802.15.4
> >default value and the range is "3..3".
> 
> Hmm, would it not make sense to assume that a transceiver which does not
> support IEEE802154_HW_FRAME_RETRIES does not support ARET at all?
> 

We indicate right now that the frame_retries value "-1" indicates that the
transceiver running in "no ARET" support.

I am fine to introduce this with a new HW flag which indicates that the
transceiver doesn't support ARET handling. But then we can also bring
the AACK flag back.

We can't forbid from stack that we doesn't send out MAC frames where the
ack request bit is set. Some of the MLME-ops requires ack handling (or
we simple don't do what the standard says and always clear this bit
before transmit when IEEE802154_HW_NO_ARET is set). Or we can also do
just printout a WARN_ONCE then that the user should buy a "real"
transceiver.

This is the same like the AACK handling flag. The mac802154 layer Should
never see any ACK frames because we can't handle them and it looks also
that when the transceivers support AACK handling, then ack frames are
completely handled by the transceiver, they don't send them to the next
layer (except if you are in promiscuous mode).

Anyway, if the transceiver doesn't support ARET _or_ AACK you _always_
running in issues in 802.15.4 networks which use acknowledge handling.

What I definitely want is to get the "-1" value out of frame_retries
behaviour. The standard says a range of "0..7" here and if the driver
implementation too poor to report it then we think it's 802.15.4 default.
There exists no value which indicates "no frame_retries handling
supported"

(In case of mrf24j40 this is also true, because it doesn't support
setting of frame_retries. It's in this case really always 3). See [0],

"The aMaxFrameRetries value is a constant and not configurable."

"... is not received after aMaxFrameRetries (3) transmissions."

The ack handling can be set by setting some bit "TXNACKREQ" and
currently the mrf24j40 implementation do this also per frame and check
on ackreq bit [1].

In my opninion, we have the frame_retries = -1 value because historical
issues and should do the handling like mrf24j40.

btw:
I currently try to work on some things on this driver.

> For me it sounds more as if we would want to set the range to 0..0 here
> because the transceiver does not support IEEE802154_HW_FRAME_RETRIES andthus
> no ARET.
> 

no, (frame_retries = 0) != no ARET.

The reason is easy, you can set frame_retries to zero and going into
ARET mode. The important thing is "the transceiver waits for an ACK
frame after transmit", if this is not see then the transceiver logic is
-> transmit failed. (In this case you have no retransmit, because
frame_retries is 0).


The diffirent between no ARET handling is, the transceiver _doesn't_ wait
for an ACK frame and it's always successful to send something out.

- Alex

[0] http://ww1.microchip.com/downloads/en/DeviceDoc/39776C.pdf
[1] http://lxr.free-electrons.com/source/drivers/net/ieee802154/mrf24j40.c#L355
