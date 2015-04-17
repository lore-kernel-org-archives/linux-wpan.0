Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35810 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbbDQWT0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 17 Apr 2015 18:19:26 -0400
Received: by widdi4 with SMTP id di4so37290345wid.0
        for <linux-wpan@vger.kernel.org>; Fri, 17 Apr 2015 15:19:25 -0700 (PDT)
Date: Sat, 18 Apr 2015 00:19:17 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: at86rf233 on BeagleBone Black
Message-ID: <20150417221913.GA3338@omega>
References: <551EDFCA.3070905@fid4.com>
 <20150403191320.GD773@omega>
 <20150414150656.GB2179@omega>
 <553024C3.2020207@fid4.com>
 <55307D66.7020606@gmail.com>
 <55310A85.5080601@fid4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55310A85.5080601@fid4.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Michael C. Cambria" <mcc@fid4.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

On Fri, Apr 17, 2015 at 09:28:37AM -0400, Michael C. Cambria wrote:
...
> >>
> 
> With those changes the "arguments longer than property" message does go
> away.  I now get this probe error:
> 
> 
> [    9.815400] of_get_named_gpiod_flags: parsed 'reset-gpio' property of
> node '/ocp/spi@481a0000/at86rf231@0[0]' - stat)
> [    9.815437] of_get_named_gpiod_flags: parsed 'sleep-gpio' property of
> node '/ocp/spi@481a0000/at86rf231@0[0]' - stat)
> [   10.287193] at86rf230 spi1.0: Non-Atmel dev found (MAN_ID 00 00)
> [   10.971416] at86rf230: probe of spi1.0 failed with error -22
> 

Meanwhile I got private repsonse that somebody have a working openlabs
module on a beaglebone, so it's _really_ possible! :-)

Your issue now seems that you reading zero's only on the spi bus. Please
remember that we can't know your GPIO setup to the beaglebone pinout
headers. Maybe your reset pin is always low and then the at86rf233 will
not work. You need to know on which GPIO is reset pin/irq pin/sleep etc.

- Alex
