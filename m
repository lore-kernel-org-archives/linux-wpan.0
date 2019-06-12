Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lj1-f179.google.com ([209.85.208.179]:36547 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729210AbfFLWw2 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 12 Jun 2019 18:52:28 -0400
Received: by mail-lj1-f179.google.com with SMTP id i21so16599501ljj.3
        for <linux-wpan@vger.kernel.org>; Wed, 12 Jun 2019 15:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8U23aVH+O+4OWQrkG-Q+Kf2sD7DhvpDpO8+3C94Y9bE5k8ww@mail.gmail.com>
 <20190612141016.owy6csdatcugsgak@x220t> <CAK8U23ZW+4MXkTcmzR9VV=Kw__wfEoXqvphEbH7ZPSe7rGH2Gw@mail.gmail.com>
 <20190612172028.2fxq6jsj5jsq5pca@x220t> <20190612195958.ukblxedzxwr6hvdk@x220t>
In-Reply-To: <20190612195958.ukblxedzxwr6hvdk@x220t>
From: Ramon Fontes <ramonreisfontes@gmail.com>
Date: Wed, 12 Jun 2019 19:52:15 -0300
Message-ID: <CAK8U23bFrQ07gmTdWVM8FZm8Xhbe3041XzaKagti_mzxVRAUiQ@mail.gmail.com>
Subject: Re: Simulating 6lowpan with mac802154_hwsim
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>
Cc: linux-wpan@vger.kernel.org

For LQI this is not true, because in mac802154_hwsim you say edges as a
set of vectors (which node can reach the other node) and specify the LQI
value which the receiving node will be get.

>> Ok! I just used wpan-hwsim and it seems to work fine. However, I have another question: How can I get the LQI value? I've created a monitor interface, but I couldn't observe the LQI value.

------------------
For TC it's true, then you need to match on different addresses e.g. mac
> address/short address?

After talking with the TC maintainer, he told me it's implemented as
qdisc and not as action where you probably could do something to use
netem features per neighbor as run on specifc patterns...

>> Which patterns do you mean? Can I try the mac address with TC?

Thanks a lot for your kind help.

Regards,
Ramon

On Wed, Jun 12, 2019 at 5:00 PM Alexander Aring <aring@mojatatu.com> wrote:
>
> Hi,
>
> On Wed, Jun 12, 2019 at 01:20:28PM -0400, Alexander Aring wrote:
> > Hi,
> >
> > On Wed, Jun 12, 2019 at 02:07:26PM -0300, Ramon Fontes wrote:
> > > One node (e.g. node1) can be connected simultaneously to multiple
> > > nodes  (e.g. node2 and node3) by using only one 6lowpan interface.
> > > That said, which node (2 or 3) will node1 taking into account? They
> > > can have different distances and only one interface in which we can
> > > use TC. Please correct me if I'm wrong. In my mind, the same is true
> > > for LQI.
> > >
> >
> > For TC it's true, then you need to match on different addresses e.g. mac
> > address/short address?
>
> After talking with the TC maintainer, he told me it's implemented as
> qdisc and not as action where you probably could do something to use
> netem features per neighbor as run on specifc patterns...
>
> - Alex
