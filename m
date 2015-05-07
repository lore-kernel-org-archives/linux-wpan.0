Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37928 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbbEGRVk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 7 May 2015 13:21:40 -0400
Received: by wiun10 with SMTP id n10so68090920wiu.1
        for <linux-wpan@vger.kernel.org>; Thu, 07 May 2015 10:21:39 -0700 (PDT)
Date: Thu, 7 May 2015 19:21:33 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Oops with latest bluetooth-next kernel.
Message-ID: <20150507172132.GA1256@omega>
References: <554B414B.50408@xsilon.com>
 <20150507122441.GA17485@omega>
 <554B8456.9090107@xsilon.com>
 <20150507170052.GA714@omega>
 <20150507171049.GB714@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150507171049.GB714@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-wpan@vger.kernel.org

On Thu, May 07, 2015 at 07:10:49PM +0200, Alexander Aring wrote:
> On Thu, May 07, 2015 at 07:00:52PM +0200, Alexander Aring wrote:
> > Hi,
> > 
> > On Thu, May 07, 2015 at 04:27:18PM +0100, Martin Townsend wrote:
> > > Thanks for your reply Alex,  after a bit of debugging I've tracked it down to our RPL application.  If I disable this at startup there are no lock ups.  As soon as I start the daemon it brings the Kernel down so I need to investigate why this happens.
> > > 
> > > I'll have a go at updating the fakelb as it's useful for RPL and MPL.
> > > 
> > 
> > ok.
> > 
> > I also note on your outputs that the MIB defaults different what we have
> > currently.
> > 
> >         Interface wpan2
> >                 ifindex 12
> >                 wpan_dev 0x200000002
> >                 extended_addr 0x1013749720940844
> >                 short_addr 0xffff
> >                 pan_id 0xffff
> >                 type node
> >                 max_frame_retries 4
> > hehe, our mib default is -1 (no aret/csma-ca).
> 
> meant here:
> 
> "here, our mib default is -1 (no aret/no csma-ca). In general the
> max_frame_retries values should follow the following behaviour:
> 
> -1   =	(no aret/no csma-ca)
> 0    =	(no aret/csma-ca)

in this case, other nodes should handle ack frames.

> 1..7 =	(aret/csma-ca)
> 
> but the only mainline driver which supports this setting is the
> atrf86rf230. When the driver doesn't implement to change this value we
> assuming 802.15.4 defaults which is 3. So it depends on the
> implementation if the these settings "do really any change".
> 
> btw:. currently it's not true that we set max_frame_retries to 3, it's
> -1 but there are many TODO's and we should set it to 802.15.4 default
> value which is 3. If you activate aret handling then this means other
> frames need to handle ack frames and this is not always supported... but

ehm, makes no sense:

s/frames need to handle ack frames/nodes needs to handle ack frames/

typical this is done by AACK, so a phy do that. We can't do this in
mac802154 because timing constraints. And it's also in our driver so
that they should always support AACK handling by default. There is no
option to turn it off.


I should draw some graphic and upload it to wpan-misc to explain these
bheaviours.

- Alex
