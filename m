Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:60864 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884AbaIPNcT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Sep 2014 09:32:19 -0400
Date: Tue, 16 Sep 2014 15:32:08 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v4 bluetooth] 6lowpan: fix incorrect return values in
 lowpan_rcv
Message-ID: <20140916133206.GA6104@omega>
References: <5418215F.5050308@xsilon.com>
 <20140916114759.GD4969@omega>
 <20140916115357.GE4969@omega>
 <20140916120247.GA5217@omega>
 <20140916121844.GA5349@omega>
 <54182C6B.6090801@xsilon.com>
 <20140916123421.GA5576@omega>
 <54182FB8.4080103@xsilon.com>
 <20140916124832.GB5576@omega>
 <1410873619.4860.20.camel@jrissane-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1410873619.4860.20.camel@jrissane-mobl.ger.corp.intel.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Martin Townsend <martin.townsend@xsilon.com>, Martin Townsend <mtownsend1973@gmail.com>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org

Hi Jukka,

On Tue, Sep 16, 2014 at 04:20:19PM +0300, Jukka Rissanen wrote:
> Hi Alex,
> 
> On ti, 2014-09-16 at 14:48 +0200, Alexander Aring wrote:
> > Hi Martin,
> > 
> > On Tue, Sep 16, 2014 at 01:40:24PM +0100, Martin Townsend wrote:
> > ...
> > > 
> > > Yes I see the problem now, maybe it's better to revert back to skb_inout, less chance of introducing bugs and then we have a well defined return value.
> > > 
> > 
> > No problem, for me it's okay, if this is okay for Jukka, we can change
> > it later to a better behaviour. Jukka please answer what you think about this.
> > 
> 
> What about doing things like this in your example?
> 

ehm yes, the example is only there to describe the current situation.

> > I also did a small c example because this now:
> > 
> > char *foo(char *buf)
> > {
> >         char *new;
> > 
> >         if (some_error)
> >                 return NULL;
> 
> In this case you should probably not return NULL but something like
> -EINVAL
> 
> if (some_error) {
> 	free(buf);
> 	return -EINVAL;
> }

yes, that's the second choice, let do consume_skb/kfree_skb inside
lowpan_process_data function.

> 
> > 
> >         if (some_error)
> >                 return NULL;
> 
> Ditto
> 
> > 
> >         new = expand(buf, 23);
> >         if (!new)
> >                 return NULL;
> 
> if (!new) {
> 	free(buf);
> 	return -ENOMEM;
> }
> 
> > 
> >         free(buf);
> >         buf = new;
> > 
> > 	/* buf is now different than the parameter buf */
> >         if (some_error)
> >                 return NULL;
> 
> if (some_error) {
> 	free(buf);
> 	return -EFOOBAR;
> }
> 
> >              
> >         return buf;
> > }             
> >               
> > int main(int argc, const char *argv[])
> > {             
> >         char *local_buf = malloc(42);
> >         char *buf;
> >              
> >         buf = foo(local_buf);
> >         if (!buf) {
> >                 /* BUG */
> >                 /* we don't know if local_buf is still valid. */
> >                 free(local_buf);
> >         }        
> 
> if (IS_ERR_OR_NULL(buf)) {
> 	fail();
> } else
> 	free(buf);
> 
> >                  
> >         return 0;
> > }
> > 
> > I think if you do buf = foo(buf) you can rescue it but this doesn't
> > look like a clean solution for me.
> > 
> > - Alex
> 
> 
> In this simplified example, the subroutine frees the buf which does not
> look nice I have to admit.
> 

I am also fine with this solution. Make something I will review it and
look if we run into trouble.

In my last mails stands, that we have two choices:

- make the skb_inout thingy
- handle error freeing into lowpan_process_data function.

You described the last one now. :-)

- Alex
