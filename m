Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lj1-f169.google.com ([209.85.208.169]:43776 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438289AbfFLRHk (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 12 Jun 2019 13:07:40 -0400
Received: by mail-lj1-f169.google.com with SMTP id 16so15742672ljv.10
        for <linux-wpan@vger.kernel.org>; Wed, 12 Jun 2019 10:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8U23aVH+O+4OWQrkG-Q+Kf2sD7DhvpDpO8+3C94Y9bE5k8ww@mail.gmail.com>
 <20190612141016.owy6csdatcugsgak@x220t>
In-Reply-To: <20190612141016.owy6csdatcugsgak@x220t>
From: Ramon Fontes <ramonreisfontes@gmail.com>
Date: Wed, 12 Jun 2019 14:07:26 -0300
Message-ID: <CAK8U23ZW+4MXkTcmzR9VV=Kw__wfEoXqvphEbH7ZPSe7rGH2Gw@mail.gmail.com>
Subject: Re: Simulating 6lowpan with mac802154_hwsim
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>
Cc: linux-wpan@vger.kernel.org

One node (e.g. node1) can be connected simultaneously to multiple
nodes  (e.g. node2 and node3) by using only one 6lowpan interface.
That said, which node (2 or 3) will node1 taking into account? They
can have different distances and only one interface in which we can
use TC. Please correct me if I'm wrong. In my mind, the same is true
for LQI.

This code (https://github.com/ramonfontes/mininet-iot/blob/master/examples/6LoWPan.py)
produce such scenario. You can also try 6lowpan.py -m for mobility
purposes.

On Wed, Jun 12, 2019 at 11:10 AM Alexander Aring <aring@mojatatu.com> wrote:
>
> On Thu, Jun 06, 2019 at 07:49:07PM -0300, Ramon Fontes wrote:
> > Hello all,
> >
> > I've been developed a wireless network emulator for IoT
> > (https://github.com/ramonfontes/mininet-iot) in which I'm using
> > mac802154_hwsim. Mininet-IoT extends Mininet-WiFi
> > (https://github.com/intrig-unicamp/mininet-wifi) by simulating WiFi
> > through mac80211_hwsim. Mininet-WiFi already supports 6lowpan with
> > fakelb and I moving everything to mac802154_hwsim. Since I'm using
> > iwpan with mac802154_hwsim and given the expertise of this community,
> > I was wondering whether there is any work in which simulate the data
> > rate based on the distance/rssi with 6lowpan. If the answer is no,
> > what would be the best way to do so? I was thinking of doing this with
> > TC, but TC wouldn't work well with multiple hops. Should I develop a
> > wmediumd-like simulator (https://github.com/bcopeland/wmediumd) for
> > mac802154_hwsim?
> >
>
> rssi as 802.15.4 LQI value can be set per hop in mac802154_hwsim netlink
> api. For delays/drops/etc. where is the problem using by TC netem?
>
> LQI value is *mostly dropped to garbage right now.
>
> It was on my list to try out netem with mac802154_hwsim but I didn't do
> it yet because I have no use case.
>
> - Alex
