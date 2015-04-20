Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:34252 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbbDTSY6 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Apr 2015 14:24:58 -0400
Received: by wgso17 with SMTP id o17so188895529wgs.1
        for <linux-wpan@vger.kernel.org>; Mon, 20 Apr 2015 11:24:56 -0700 (PDT)
Date: Mon, 20 Apr 2015 20:24:53 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: at86rf233 on BeagleBone Black
Message-ID: <20150420182449.GC707@omega>
References: <551EDFCA.3070905@fid4.com>
 <20150403191320.GD773@omega>
 <20150414150656.GB2179@omega>
 <553024C3.2020207@fid4.com>
 <55307D66.7020606@gmail.com>
 <55310A85.5080601@fid4.com>
 <20150417221913.GA3338@omega>
 <55353FC0.5050909@fid4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55353FC0.5050909@fid4.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Michael C. Cambria" <mcc@fid4.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

Hi,

On Mon, Apr 20, 2015 at 02:04:48PM -0400, Michael C. Cambria wrote:
> 
> 
> On 04/17/2015 06:19 PM, Alexander Aring wrote:
> >On Fri, Apr 17, 2015 at 09:28:37AM -0400, Michael C. Cambria wrote:
> >....
> >>With those changes the "arguments longer than property" message does go
> >>away.  I now get this probe error:
> >>
> >>
> >>[    9.815400] of_get_named_gpiod_flags: parsed 'reset-gpio' property of
> >>node '/ocp/spi@481a0000/at86rf231@0[0]' - stat)
> >>[    9.815437] of_get_named_gpiod_flags: parsed 'sleep-gpio' property of
> >>node '/ocp/spi@481a0000/at86rf231@0[0]' - stat)
> >>[   10.287193] at86rf230 spi1.0: Non-Atmel dev found (MAN_ID 00 00)
> >>[   10.971416] at86rf230: probe of spi1.0 failed with error -22
> >>
> >Meanwhile I got private repsonse that somebody have a working openlabs
> >module on a beaglebone, so it's _really_ possible! :-)
> 
> Thanks for all the help.  My BBB now works with the openlabs radio.  I had
> P9_28 & P9_30 in the the wrong holes (blush).
> 
> I still have those two messages at modprobe time, but the radio is probed.
> 
> [   11.346020] of_get_named_gpiod_flags: parsed 'reset-gpio' property of
> node '/ocp/spi@481a0000/at86rf233@0[0]' - status (0)
> [   11.346056] of_get_named_gpiod_flags: parsed 'sleep-gpio' property of
> node '/ocp/spi@481a0000/at86rf233@0[0]' - status (0)
> [   11.349282] at86rf230 spi1.0: Detected at86rf233 chip version 1
> 

yes, I think that means "everything okay!" status 0 means success and
the last message is a successful probing message of the at86rf230
driver.

So that's normal, if you don't want to printout these messages you need
to change your loglevel.

- Alex
