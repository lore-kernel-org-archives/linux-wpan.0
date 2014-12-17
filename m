Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:61820 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbaLQIyO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 17 Dec 2014 03:54:14 -0500
Received: by mail-wg0-f44.google.com with SMTP id b13so19703852wgh.31
        for <linux-wpan@vger.kernel.org>; Wed, 17 Dec 2014 00:54:13 -0800 (PST)
Date: Wed, 17 Dec 2014 09:54:10 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-misc] website: add cc2520 support entry
Message-ID: <20141217085405.GB21360@omega>
References: <1418789375-5450-1-git-send-email-varkab@cdac.in>
 <20141217081038.GA21360@omega>
 <CAEUmHyaYSbqwG5mUkxmMS05+PCScwL8gkS8HPaFZ_E97nacRMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEUmHyaYSbqwG5mUkxmMS05+PCScwL8gkS8HPaFZ_E97nacRMQ@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>, Varka Bhadram <varkab@cdac.in>

Hi,

On Wed, Dec 17, 2014 at 02:20:18PM +0530, Varka Bhadram wrote:
> On Wed, Dec 17, 2014 at 1:40 PM, Alexander Aring <alex.aring@gmail.com>
> wrote:
> >
> > Hi Varka,
> >
> > On Wed, Dec 17, 2014 at 09:39:35AM +0530, Varka Bhadram wrote:
> > >
> > > Signed-off-by: Varka Bhadram <varkab@cdac.in>
> > > ---
> > >  website/index.txt |    1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/website/index.txt b/website/index.txt
> > > index a7ab4bb..9e4c36f 100644
> > > --- a/website/index.txt
> > > +++ b/website/index.txt
> > > @@ -33,6 +33,7 @@ Supported Hardware
> > >  |at86rf231   |yes              |at86rf230  | SPI |
> > http://downloads.qi-hardware.com/people/werner/wpan/web/[atben] Out of
> > stock. Mailto linux-wpan and Werner to produce maybe new ones. Or contact
> > http://en.qi-hardware.com/wiki/Main_Page[qi-hardware].
> > >  |at86rf233   |yes              |at86rf230  | SPI |
> > http://openlabs.co/store/Raspberry-Pi-802.15.4-radio[openlabs]
> > >  |at86rf212   |yes              |at86rf230  | SPI |
> > > +|cc2520      |yes              |cc2520     | SPI |
> > >  |atusb       |not mainline yet |atusb      | USB |
> > http://downloads.qi-hardware.com/people/werner/wpan/web/[atusb] Out of
> > stock. Mailto linux-wpan and Werner to produce maybe new ones. Or contact
> > http://en.qi-hardware.com/wiki/Main_Page[qi-hardware].
> > >  |=============================================================
> > >
> > > --
> > > 1.7.9.5
> >
> > Applied and regenerate the website, thanks.
> >
> > - Alex
> >
> 
> Thank you Alex.
> 
> The theme 'volnitsky' is looks better to me for the project. Can we use
> this..?
> 

yes, looks better. Go ahead and send patches.

- Alex
