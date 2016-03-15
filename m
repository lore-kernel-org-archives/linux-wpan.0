Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36742 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753241AbcCOFTR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 15 Mar 2016 01:19:17 -0400
Received: by mail-wm0-f47.google.com with SMTP id n186so136076145wmn.1
        for <linux-wpan@vger.kernel.org>; Mon, 14 Mar 2016 22:19:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <25857.1457997112@obiwan.sandelman.ca>
References: <CAH+RWqF-3Q8P52PTM9ZqpybEWTCKiubQK0-Y7L=c-3vAMhJfrg@mail.gmail.com>
	<20160228140659.GA17980@omega>
	<28981.1457015214@obiwan.sandelman.ca>
	<20160304083528.GA1525@omega>
	<24416.1457106776@obiwan.sandelman.ca>
	<20160304163749.GA21798@omega>
	<15462.1457122604@obiwan.sandelman.ca>
	<56E6D9F6.70308@osg.samsung.com>
	<25857.1457997112@obiwan.sandelman.ca>
Date: Tue, 15 Mar 2016 09:19:15 +0400
Message-ID: <CAH+RWqHFKj1joOtNVpP2WR=VO_mOekfek6E9EcEtFnsDj5PHCQ@mail.gmail.com>
Subject: Re: 802.15.4G support?
From: Remi Philippe <remi@linqio.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

On Tue, Mar 15, 2016 at 3:11 AM, Michael Richardson <mcr@sandelman.ca> wrote:
>
> Stefan Schmidt <stefan@osg.samsung.com> wrote:
>     > 2) If the 802.15.4g node uses a SUN PHY with a 2047 byte MTU we can run into
>     > trouble with normal nodes only able to handle 127. So far there is nothing
>     > specified to handle this case. Michael is proposing to use 6lo ND for this
>     > and record the MTU value for this neighbour in the l2 nd cache. Something
>     > that would certainly work but would need specing and implementing. I see this
>     > as a mid term goal we want to have. Anyone going to work on this?
>
> It's not even clear to me that ND can do this.
> I still propose that we want to have a space in the l2 or l3 ND cache for
> this info.  It could well go in the L3 cache because it is really a statement
> about how the 6lowpan layer should fragment.
>
>     > 3) Until 2) is done I would suggest we add a config option "802.15.4g with
>     > SUN PHY" which will change the hardcoded MTU from 127 to 2047 and will thus
>     > only work for a 15.g with SUN PHY only network. No interop as we have no way
>     > of knowing. The option would be disabled by default and the help text needs
>     > to mention the drawbacks. Once we have 2) in place we can remove this.
>
> Couldn't we use "ifconfig blah0 mtu 2047"?

Maybe we should do both, have a flag to specify the PHY type as the
PHY header is slightly different in15.4g MR-FSK to support for mode
switch, data whitening... it needs to support 2 octets header (page 52
of the 802.15.4g-2012 spec) it can also lock the max MTU supported for
the media. And allow to change the MTU from command line.

>
>     > Remis, Alex, Michael how does this sound. It would allow Remi to go ahead and
>     > do the work needed to get his driver and things for 15.4g mainline while the
>     > interop problem can get further discussed, speced and implemented. Whats your
>     > folks opinion on this?
>
>
>
> --
> ]               Never tell me the odds!                 | ipv6 mesh networks [
> ]   Michael Richardson, Sandelman Software Works        | network architect  [
> ]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [
>



-- 
Rémi Philippe - CTO
Linqio
