Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:39892 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbaIXMtp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Sep 2014 08:49:45 -0400
Received: by mail-wg0-f45.google.com with SMTP id x13so5720856wgg.16
        for <linux-wpan@vger.kernel.org>; Wed, 24 Sep 2014 05:49:44 -0700 (PDT)
Date: Wed, 24 Sep 2014 14:49:41 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH linux-wpan v4] ieee802154: 6lowpan: ensure header
 compression does not corrupt ipv6 header
Message-ID: <20140924124939.GD5246@omega>
References: <20140923093544.GB12857@omega>
 <1411467246.4860.68.camel@jrissane-mobl.ger.corp.intel.com>
 <20140923103341.GA24710@omega>
 <75E2311D-E166-4891-B57B-390E5BFC8BB5@holtmann.org>
 <20140923153601.GA16060@omega>
 <74B72B04-16AC-4E9F-B24A-C095AAE12541@holtmann.org>
 <20140924094732.GB24530@omega>
 <998C7123-CA00-49A4-A711-11F78E0A1AF1@holtmann.org>
 <20140924100437.GB5246@omega>
 <DC65D891-5AD7-48F0-B912-E6B2C0674D41@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DC65D891-5AD7-48F0-B912-E6B2C0674D41@holtmann.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>, Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org

Hi Marcel,

On Wed, Sep 24, 2014 at 02:24:44PM +0200, Marcel Holtmann wrote:
> Hi Alex,
> 
> >>>>>>>>> I/Simon mainly add you here in cc because this bug what Simon fixed here
> >>>>>>>>> is also inside of bluetooth 6lowpan.
> >>>>>>>> 
> >>>>>>>> BTW, the v4 patch does not apply cleanly to bluetooth-next. The
> >>>>>>>> modifications were very small thou.
> >>>>>>>> 
> >>>>>>> 
> >>>>>>> It's a bug fix and should be go to wpan, then wpan goes to bluetooth. I
> >>>>>>> know there is some easy solveable merge conflict... but maintainers need to be
> >>>>>>> deal with it then. ;-)
> >>>>>>> 
> >>>>>>> When this is an easy conflict it doesn't matter to wait on it. I hope
> >>>>>>> that's okay for all maintainers, I am new in this handling. Maintainers
> >>>>>>> isn't just "apply patches", making the right workflow and solve merge
> >>>>>>> conflicts, I think. Otherwise some maintainer will tell me "don't making merge
> >>>>>>> conflicts!", but I heard nothing something like that now.
> >>>>>>> 
> >>>>>>> Or we wait when these changes are in bluetooth repo, which means also
> >>>>>>> wpan repo.
> >>>>>> 
> >>>>>> since 3.17 is basically around the corner, adding it to bluetooth tree is not getting us anywhere right now. So what I would do is include it in bluetooth-next and add a CC: stable tag to it.
> >>>>>> 
> >>>>> 
> >>>>> you are right. I will try that to CC: stable on this patch. Please don't
> >>>>> be angry that I will fail there. The last time when I tried it I got a
> >>>>> formletter back. :-)
> >>>> 
> >>>> check if the patch would actually apply against 3.16.x and if it does just included CC: stable@vger.kernel.org under the signed-off-by line. If it doesn't, then we need to get the fix included first. And after the merge window we reference it by a version that applies to 3.16.x and send it to stable tree manually. However in all cases patch needs to hit Linus' tree first.
> >>>> 
> >>> 
> >>> doesn't apply against "3.16.x". I will apply it to my wpan-next testing
> >>> branch and in the next days I will send it to your bluetooth-next with a
> >>> couple of other patches.
> >> 
> >> you might want to hurry up here since if Linus releases 3.17 on Sunday, then this means the merge window has opened. So you are cutting it extremely close. I say unless we get the patches by end of today, it becomes really hard to justify pushing these into 3.18 merge window.
> >> 
> > 
> > ok, ok. I will send you what I have now. I know the "3 hops problematic"
> > patch traceroute looks like: bluetooth -> wireless -> net -> linus
> > 
> > I/We have a huge latency here.
> 
> if the merge window is around the corner, you will be in a hurry no matter what. So please do not blame the different trees a patch has to go through. This is what it is. The earlier patches are ready the less this will become a problem. We have been pushing bluetooth-next into wireless-next on a really regular basis and John has been quick in pulling stuff. So there is really not bottleneck here.

Okay, when this is no bottleneck. Sorry that I blame the different trees
in this case. Was just a mind that this could be a bottleneck. Sorry.

Next time I will send patches faster, but these 4 patches came up all
this week at linux-wpan, so there was no much patches in this period.

Other solution would be simple send all patches also 802.15.4 subsystem
directly to bluetooth. But now we have a better reviewing step before
we send it to your bluetooth tree's.

> 
> >>> My understanding is that we are close of releasing 3.17 it makes no
> >>> sense to send it to bluetooth now. When the patch hit's "linus" tree we
> >>> can make a different patch for 3.16.x and send it to -stable.
> >> 
> >> Yes. If we fixed it in Linus' tree and decide back porting it to older kernels is worth while doing, then yes, we can send a modified patch that applies to 3.17 first of all. I say 3.17 since that will be the first stable kernel it should apply to and then see what needs to be done for 3.16 and if it makes sense.
> >> 
> >> For example some Bluetooth patches we have not send for stable since the effort is too much. We send them to the stable kernel they still apply to and once they stop applying, we ignored them until real bugs are have been filed. Remember that not every bug is something that needs fixing in stable kernel.
> >> 
> > 
> > ehm, yes effort is sometimes also too much here...
> > 
> > I mean, if somebody wants this in stable version x.y.z I am happy that
> > somebody do the effort and porting this back. But I don't want to
> > backport all fixes into -stable and for each stable branch. Sometimes
> > that's also not possible.
> 
> My advise is just don't. Unless it is trivial and an obvious fix. Hurrying things into stable is wrong in my opinion. I only tag for stable when it is a real issue that causes long term issues. That is why I hate if individual patch submitters tag things for stable. Your own patch is always the most important one, but in the big picture it might not be. So I would not worry too much about stable. Getting patches quickly into next trees is more important in my opinion.
> 

Okay, I already told people that they should not use any stable kernel
for the 802.15.4 subsystem. Then I will not care about -stable branch,
it's okay for me. Otherwise I will getting crazy to care that everything
will work in -stable tree's.

- Alex
