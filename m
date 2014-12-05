Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38183 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751874AbaLELPU (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 5 Dec 2014 06:15:20 -0500
Message-ID: <1417778102.32209.2.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH bluetooth-next 1/5] net/6lowpan: Remove FSF address from
 GPL statement.
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Fri, 05 Dec 2014 13:15:02 +0200
In-Reply-To: <1417690321-19450-1-git-send-email-s.schmidt@samsung.com>
References: <1417690321-19450-1-git-send-email-s.schmidt@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <s.schmidt@samsung.com>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>

On to, 2014-12-04 at 11:51 +0100, Stefan Schmidt wrote:
> This might change and we already deliver a copy of the license with
> the kernel. This was already removed form the ieee802154 code but
> missed here.
> 
> Signed-off-by: Stefan Schmidt <s.schmidt@samsung.com>
> CC: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
>  net/6lowpan/iphc.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index aced97d..32ffec6 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -15,9 +15,6 @@
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   * GNU General Public License for more details.
>   *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write to the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>   */
>  
>  /* Jon's code is based on 6lowpan implementation for Contiki which is:


Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka



