Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33289 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031607AbbD2JHb (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Apr 2015 05:07:31 -0400
Received: by wief7 with SMTP id f7so35263324wie.0
        for <linux-wpan@vger.kernel.org>; Wed, 29 Apr 2015 02:07:29 -0700 (PDT)
Date: Wed, 29 Apr 2015 11:07:21 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next 09/15] ieee802154: add support for get tx
 powers
Message-ID: <20150429090717.GA1170@omega>
References: <1429807674-24849-1-git-send-email-alex.aring@gmail.com>
 <1429807674-24849-10-git-send-email-alex.aring@gmail.com>
 <20150427134932.64e5325a@zoidberg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150427134932.64e5325a@zoidberg>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Phoebe,

On Mon, Apr 27, 2015 at 01:49:32PM +0200, Phoebe Buckheister wrote:
> On Thu, 23 Apr 2015 18:47:48 +0200
> Alexander Aring <alex.aring@gmail.com> wrote:
> 
...
> > +	int		(*get_tx_powers)(struct ieee802154_hw
> > *hw, s8 *dbm,
> > +					 u32 idx);
> 
> I suggest you use mBm instead of dBm here, while you're at it anyway.
> Especially since one of your later patches will add incorrect values
> because dBm isn't accurate enough for what the transceiver support
> (rf230, TX power +3.4dBm). This would also make the value-2 return you
> have right now unnecessary.
> 

The 802.15.4 standard describes in the phy pib for tx power:

attr: phyTXPower
type: signed integer
range: -
describtion: The transmit power of the device in dBm.

I mentioned in my previous mail that this doesn't repsonse the reality
because there are transceivers outside which supports tx power in dbm
which are not signed integer, like +3.4 dbm.

Nevertheless I would say forget that what the PIB says, we do what the
reality does now. (In my previous mail I was another opinion because the
current type is s8). I think we should not do that now, because we get
trouble later, this is what you mentioned now and I agree.


Plan to implement the mbm:

1. change current tx power to S32 instead s8.
   I gave it a try phy dump with iwpan still works, (not ends in a
   critical error), so I will change it.

2. the kernelside use mbm everywhere the userspace side kann convert the
   dbm values to mbm then with a calculation "dbm = mbm / 100" and
   "mbm = dbm * 100".

   Some helper marcos like:
   #define DBM_TO_MBM(gain) ((int)(((float)gain) * 100))
   #define MBM_TO_DBM(gain) ((float)(gain) / 100)

Examples
   MBM    | DBM
   +230   | +2.3
   -280   | -2.8
   ...    | ....

Thanks, for the review.

- Alex
